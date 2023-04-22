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
    add = { hl = "GitSignsAdd", text = "A|", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "C|", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "D_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "D‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "D~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
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
  current_line_blame_formatter_opts = {
    relative_time = false,
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
  yadm = {
    enable = false,
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
    end, { expr = true })

    map("n", keys.gitsigns.prev_hunk, function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    map({ "n", "v" }, keys.gitsigns.stage_hunk, ":Gitsigns stage_hunk<CR>")
    map("n", keys.gitsigns.stage_buffer, gs.stage_buffer)
    map("n", keys.gitsigns.undo_stage_hunk, gs.undo_stage_hunk)
    map({ "n", "v" }, keys.gitsigns.reset_hunk, ":Gitsigns reset_hunk<CR>")
    map("n", keys.gitsigns.reset_buffer, gs.reset_buffer)
    map("n", keys.gitsigns.prev_hunk, gs.preview_hunk)
    map("n", keys.gitsigns.blame_line, function()
      gs.blame_line({ full = true })
    end)
    map("n", keys.gitsigns.diffthis, gs.diffthis)
    map("n", keys.gitsigns.diff, function()
      gs.diffthis("~")
    end)
    -- toggle
    map("n", keys.gitsigns.toggle_deleted, gs.toggle_deleted)
    map("n", keys.gitsigns.toggle_current_line_blame, gs.toggle_current_line_blame)
    -- Text object
    map({ "o", "x" }, keys.gitsigns.select_hunk, ":<C-U>Gitsigns select_hunk<CR>")
  end
})
