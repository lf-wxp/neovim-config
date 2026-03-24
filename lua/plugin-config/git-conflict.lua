-- ╭────────────────────────────────────────────────────────╮
-- │     git-conflict.nvim - Git Conflict Resolution        │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

-- ╭─────────────────────────────────────────────────────╮
-- │  Lightweight conflict state detection for lazy.nvim │
-- │  Loads plugin only when git is in merge/rebase      │
-- │  conflict state. Cost: a few fs_stat calls only     │
-- ╰─────────────────────────────────────────────────────╯
M.init = function()
  local function is_git_conflicted(gitdir)
    local indicators = {
      gitdir .. "/MERGE_HEAD",
      gitdir .. "/REBASE_HEAD",
      gitdir .. "/rebase-merge",
      gitdir .. "/rebase-apply",
    }
    for _, path in ipairs(indicators) do
      if vim.loop.fs_stat(path) then return true end
    end
    return false
  end

  local group = vim.api.nvim_create_augroup("GitConflictLazyLoad", { clear = true })
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = group,
    callback = function(args)
      local buf_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(args.buf), ":h")
      if buf_dir == "" or buf_dir == "." then return end

      -- Fast check: does current or parent directory have .git
      local gitdir = vim.fn.finddir(".git", buf_dir .. ";")
      if gitdir == "" then return end

      -- Convert to absolute path
      gitdir = vim.fn.fnamemodify(gitdir, ":p"):gsub("/$", "")

      if is_git_conflicted(gitdir) then
        -- Conflict detected! Load plugin and cleanup autocmd
        vim.api.nvim_del_augroup_by_id(group)
        require("lazy").load({ plugins = { "git-conflict.nvim" } })
      end
    end,
  })
end

M.setup = function()
  local keys = require("config.keymaps").gitConflict

  -- Ensure Source highlight groups exist before plugin setup, so plugin can read background values
  local hl_mod = require("plugin-config.highlights")
  hl_mod.setup_git_conflict_highlights()

  require("git-conflict").setup({
    default_mappings = false, -- Disable default keymaps, use centralized keymaps
    default_commands = true, -- Enable default commands (:GitConflictXxx)
    disable_diagnostics = false, -- Show diagnostics in conflict regions
    list_opener = "copen", -- Command to open conflict list
    highlights = {
      -- Point to custom Source highlight groups, plugin's set_highlights() reads background from these
      -- More reliable than DiffAdd/DiffText, colors fully under our control
      current = "GitConflictCurrentSource",
      incoming = "GitConflictIncomingSource",
      ancestor = "GitConflictAncestorSource",
    },
  })

  -- Force override final highlight groups after plugin setup (ensure foreground color for readability)
  hl_mod.setup_git_conflict_highlights()

  -- ╭─────────────────────────────────────────────────────╮
  -- │              Keymaps                                │
  -- ╰─────────────────────────────────────────────────────╯
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  local function map(mode, lhs, rhs, desc)
    keymap(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
  end

  -- Conflict selection
  map("n", keys.choose_ours, "<cmd>GitConflictChooseOurs<cr>", "Conflict: Choose Ours (current)")
  map("n", keys.choose_theirs, "<cmd>GitConflictChooseTheirs<cr>", "Conflict: Choose Theirs (incoming)")
  map("n", keys.choose_both, "<cmd>GitConflictChooseBoth<cr>", "Conflict: Choose Both")
  map("n", keys.choose_none, "<cmd>GitConflictChooseNone<cr>", "Conflict: Choose None")

  -- Conflict navigation
  map("n", keys.next_conflict, "<cmd>GitConflictNextConflict<cr>", "Next Conflict")
  map("n", keys.prev_conflict, "<cmd>GitConflictPrevConflict<cr>", "Prev Conflict")

  -- Conflict list
  map("n", keys.list_conflicts, "<cmd>GitConflictListQf<cr>", "List All Conflicts (Quickfix)")

  -- ╭─────────────────────────────────────────────────────╮
  -- │  Compensatory scan: plugin loaded after detecting   │
  -- │  conflict in init, plugin's internal BufRead        │
  -- │  autocmd missed current buffer, manually refresh    │
  -- │  to trigger conflict detection and highlights       │
  -- ╰─────────────────────────────────────────────────────╯
  vim.schedule(function()
    vim.cmd("GitConflictRefresh")
  end)
end

return M
