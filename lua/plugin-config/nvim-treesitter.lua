-- ╭────────────────────────────────────────────────────────╮
-- │        nvim-treesitter - Syntax Highlight Config       │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

-- Languages to ensure installed
local ensure_installed = {
  "json",
  "html",
  "css",
  "vim",
  "lua",
  "markdown",
  "markdown_inline",
  "javascript",
  "typescript",
  "tsx",
  "vue",
  "rust",
  "scss",
  "vimdoc",
  "regex",
  -- Additional common languages (toml for Rust ecosystem, yaml/bash for config files, etc.)
  "python",
  "toml",
  "yaml",
  "bash",
  "gitcommit",
  "diff",
  "dockerfile",
  "graphql",
}

-- ── tree-sitter CLI Check & Auto-Install ──
-- The `main` branch of nvim-treesitter compiles parsers via the standalone
-- `tree-sitter` CLI (NOT a C compiler). If the CLI is missing, parser
-- installation fails with:
--   Error during "tree-sitter build": ... ENOENT ... (cmd): 'tree-sitter'
--
-- NOTE: Homebrew's `tree-sitter` formula only ships the C library, not the
-- CLI. The CLI is provided by the `tree-sitter-cli` crate (cargo) or the
-- `tree-sitter-cli` npm package.
--
-- Returns true if the CLI is available (already present or just installed).
local ensure_tree_sitter_cli = function()
  if vim.fn.executable("tree-sitter") == 1 then
    return true
  end

  local notify = function(msg, level)
    vim.schedule(function()
      vim.notify(msg, level, { title = "nvim-treesitter" })
    end)
  end

  -- Pick an available installer, preferring cargo (most complete CLI).
  local installers = {
    { exe = "cargo", cmd = { "cargo", "install", "tree-sitter-cli" } },
    { exe = "npm", cmd = { "npm", "install", "-g", "tree-sitter-cli" } },
    { exe = "brew", cmd = { "brew", "install", "tree-sitter-cli" } },
  }

  local chosen
  for _, item in ipairs(installers) do
    if vim.fn.executable(item.exe) == 1 then
      chosen = item
      break
    end
  end

  if not chosen then
    notify(
      "'tree-sitter' CLI not found and no installer (cargo/npm/brew) available.\n"
        .. "Install it manually, e.g.: cargo install tree-sitter-cli",
      vim.log.levels.ERROR
    )
    return false
  end

  notify(
    "'tree-sitter' CLI not found. Installing via `" .. table.concat(chosen.cmd, " ") .. "`...",
    vim.log.levels.WARN
  )

  -- Run the install asynchronously so startup is not blocked.
  vim.system(chosen.cmd, { text = true }, function(result)
    if result.code == 0 and vim.fn.executable("tree-sitter") == 1 then
      notify(
        "'tree-sitter' CLI installed successfully. Run :TSInstallEnsure to compile parsers.",
        vim.log.levels.INFO
      )
    else
      notify(
        "Failed to install 'tree-sitter' CLI (exit " .. tostring(result.code) .. ").\n"
          .. (result.stderr or "")
          .. "\nInstall manually: cargo install tree-sitter-cli",
        vim.log.levels.ERROR
      )
    end
  end)

  -- Not available synchronously yet; parser install will be retried later.
  return false
end

M.setup = function()
  -- ── Treesitter Base Config ──
  -- New nvim-treesitter setup only accepts basic options like install_dir
  -- highlight / indent are built into Neovim core, no extra config needed
  require("nvim-treesitter").setup()

  -- jsonc has no dedicated parser; reuse the json parser for jsonc filetype.
  -- (Avoids the "skipping unsupported language: jsonc" warning on startup.)
  vim.treesitter.language.register("json", "jsonc")

  -- ── Ensure Missing Parsers Installed ──
  -- Skip when the tree-sitter CLI is unavailable (auto-install runs async;
  -- once done, run :TSInstallEnsure or restart to compile parsers).
  M.install_missing = function()
    local installed = require("nvim-treesitter.config").get_installed()
    local missing = vim.tbl_filter(function(lang)
      return not vim.list_contains(installed, lang)
    end, ensure_installed)

    if #missing > 0 then
      require("nvim-treesitter.install").install(missing)
    end
  end

  if ensure_tree_sitter_cli() then
    M.install_missing()
  end

  -- Manual command to (re)compile missing parsers once the CLI is ready.
  vim.api.nvim_create_user_command("TSInstallEnsure", function()
    if vim.fn.executable("tree-sitter") == 1 then
      M.install_missing()
    else
      vim.notify(
        "'tree-sitter' CLI still not found in PATH. Install: cargo install tree-sitter-cli",
        vim.log.levels.ERROR,
        { title = "nvim-treesitter" }
      )
    end
  end, { desc = "Install any missing treesitter parsers (requires tree-sitter CLI)" })

  -- ── Highlight Config ──
  -- Auto-enable treesitter highlighting for all files with a parser
  -- (Neovim 0.11 built-in ftplugin only enables for lua/help/query, others need manual enabling)
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
    callback = function(args)
      local bufnr = args.buf
      -- Skip treesitter highlighting for very large files
      local line_count = vim.api.nvim_buf_line_count(bufnr)
      if line_count > 10000 then
        return
      end
      -- Try enabling treesitter highlighting, silently fail if no parser available
      local ok = pcall(vim.treesitter.start, bufnr)
      if ok then
        -- Also enable treesitter indentation
        vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })

  -- ── Textobjects Config ──
  require("nvim-treesitter-textobjects").setup({
    select = {
      lookahead = true,
    },
    move = {
      set_jumps = true,
    },
  })

  -- ── Textobjects Select Mappings ──
  local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject
  local select_keymaps = {
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
    ["ac"] = "@class.outer",
    ["ic"] = "@class.inner",
    ["ai"] = "@conditional.outer",
    ["ii"] = "@conditional.inner",
    ["al"] = "@loop.outer",
    ["il"] = "@loop.inner",
    ["ab"] = "@block.outer",
    ["ib"] = "@block.inner",
  }
  for key, query in pairs(select_keymaps) do
    vim.keymap.set({ "x", "o" }, key, function()
      select_textobject(query)
    end, { desc = "Textobject: " .. query })
  end

  -- ── Textobjects Swap Mappings ──
  local swap = require("nvim-treesitter-textobjects.swap")
  local swap_keys = require("config.keymaps").treesitterSwap
  vim.keymap.set("n", swap_keys.swap_next, function()
    swap.swap_next("@parameter.inner")
  end, { desc = "Swap next parameter" })
  vim.keymap.set("n", swap_keys.swap_prev, function()
    swap.swap_previous("@parameter.inner")
  end, { desc = "Swap previous parameter" })

  -- ── Textobjects Move Mappings ──
  local move = require("nvim-treesitter-textobjects.move")
  local move_keymaps = {
    { "]m", move.goto_next_start, "@function.outer", "Next function start" },
    { "]]", move.goto_next_start, "@class.outer", "Next class start" },
    { "]M", move.goto_next_end, "@function.outer", "Next function end" },
    { "][", move.goto_next_end, "@class.outer", "Next class end" },
    { "[m", move.goto_previous_start, "@function.outer", "Prev function start" },
    { "[[", move.goto_previous_start, "@class.outer", "Prev class start" },
    { "[M", move.goto_previous_end, "@function.outer", "Prev function end" },
    { "[]", move.goto_previous_end, "@class.outer", "Prev class end" },
  }
  for _, map in ipairs(move_keymaps) do
    vim.keymap.set({ "n", "x", "o" }, map[1], function()
      map[2](map[3])
    end, { desc = map[4] })
  end

  -- ── Incremental Selection (treesitter node-based) ──
  local current_node = nil

  -- Special buffer types where <CR> should not be overridden
  local cr_excluded_ft = {
    "qf", "help", "man", "lspinfo", "spectre_panel", "NvimTree",
    "TelescopePrompt", "TelescopeResults", "Trouble", "toggleterm",
    "DressingSelect", "lazy", "mason", "noice", "notify",
  }

  -- Initialize / expand selection
  vim.keymap.set({ "n", "x" }, "<CR>", function()
    -- In special windows, preserve native <CR> behavior
    local ft = vim.bo.filetype
    if vim.tbl_contains(cr_excluded_ft, ft) or vim.bo.buftype ~= "" then
      return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
    end

    local node = current_node
    if not node then
      node = vim.treesitter.get_node()
    else
      node = node:parent()
    end
    if not node then
      return
    end
    current_node = node
    local sr, sc, er, ec = node:range()
    -- Enter visual mode and select node range
    vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
    vim.cmd("normal! v")
    vim.api.nvim_win_set_cursor(0, { er + 1, math.max(0, ec - 1) })
  end, { desc = "Incremental selection (expand)" })

  -- Shrink selection
  vim.keymap.set("x", "<BS>", function()
    if current_node then
      local child = current_node:child(0)
      if child then
        current_node = child
      else
        -- No child node, go back to node at cursor position
        current_node = vim.treesitter.get_node()
      end
    else
      current_node = vim.treesitter.get_node()
    end
    if not current_node then
      return
    end
    local sr, sc, er, ec = current_node:range()
    vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
    vim.cmd("normal! v")
    vim.api.nvim_win_set_cursor(0, { er + 1, math.max(0, ec - 1) })
  end, { desc = "Incremental selection (shrink)" })

  -- Reset state when leaving visual mode
  vim.api.nvim_create_autocmd("ModeChanged", {
    group = vim.api.nvim_create_augroup("treesitter_incremental_selection", { clear = true }),
    pattern = "[vV\x16]*:n",
    callback = function()
      current_node = nil
    end,
  })
end

return M
