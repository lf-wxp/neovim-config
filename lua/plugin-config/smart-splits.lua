-- ╭────────────────────────────────────────────────────────╮
-- │          smart-splits - Window Management Config       │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.opts = {
  -- Attemps to be an opinionated default
  ignored_filetypes = { "nofile", "quickfix", "prompt" },
  ignored_buftypes = { "NvimTree" },
  -- Default mappings are disabled since we use custom keymaps
  default_mappings = false,
  -- Move cursor modifier key behavior (optional)
  move_cursor_same_row = true,
  -- Cursor behavior when moving windows
  cursor_follows_swapped_bufs = true,

  -- ╭─────────────────────────────────────────────────────╮
  -- │  Resize Settings - Smooth Window Animation          │
  -- ╰─────────────────────────────────────────────────────╯
  resize_mode = {
    quit_key = "<ESC>",
    resize_keys = { "h", "j", "k", "l" },
    silent = false,
    hooks = {
      on_enter = function()
        vim.notify("Window Resize Mode: Use h/j/k/l to resize, <ESC> to quit", vim.log.levels.INFO)
      end,
      on_leave = function()
        -- Clean up any temporary highlights
      end,
    },
  },

  -- ╭─────────────────────────────────────────────────────╮
  -- │  Default Amounts                                    │
  -- ╰─────────────────────────────────────────────────────╯
  default_amount = 3,
  move_amount = 5,
}

M.setup = function()
  require("smart-splits").setup(M.opts)
end

return M
