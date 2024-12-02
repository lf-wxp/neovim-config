local keys = require("keybindings")
-- https://github.com/lewis6991/gitsigns.nvim
local status, gitsigns = pcall(require, "gitsigns")
if not status then
  vim.notify("没有找到 gitsigns")
  return
end

gitsigns.setup({
  -- 字母图标 A 增加，C修改，D 删除
  signs = {
    add = { text = "A|" },
    change = { text = "C|", },
    delete = { text = "D_", },
    topdelete = { text = "D‾", },
    changedelete = { text = "D~", },
  },
  -- 显示图标
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  -- 行数高亮
  numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = true,  -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", keys.gitsigns.next_hunk, function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "git next hunk" })

    map("n", keys.gitsigns.prev_hunk, function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "git prev hunk" })

    map({ "n", "v" }, keys.gitsigns.stage_hunk, ":Gitsigns stage_hunk<cr>", { desc = "git stage hunk" })
    map("n", keys.gitsigns.stage_buffer, gs.stage_buffer, { desc = "git stage buffer" })
    map("n", keys.gitsigns.undo_stage_hunk, gs.undo_stage_hunk, { desc = "git undo stage" })
    map({ "n", "v" }, keys.gitsigns.reset_hunk, ":Gitsigns reset_hunk<cr>", { desc = "git reset hunk" })
    map("n", keys.gitsigns.reset_buffer, gs.reset_buffer, { desc = "git reset buffer" })
    map("n", keys.gitsigns.prev_hunk, gs.preview_hunk, { desc = "git preview hunk" })
    map("n", keys.gitsigns.blame_line, function()
      gs.blame_line({ full = true })
    end, { desc = "git blame line" })
    map("n", keys.gitsigns.diffthis, gs.diffthis, { desc = "git diff this" })
    map("n", keys.gitsigns.diff, function()
      gs.diffthis("~")
    end, { desc = "git diff" })
    -- toggle
    map("n", keys.gitsigns.toggle_deleted, gs.toggle_deleted, { desc = "git toggle deleted" })
    map("n", keys.gitsigns.toggle_current_line_blame, gs.toggle_current_line_blame,
      { desc = "git toggle current line blame" })
    -- Text object
    map({ "o", "x" }, keys.gitsigns.select_hunk, ":<C-U>Gitsigns select_hunk<cr>", { desc = "git select hunk" })
  end
})
