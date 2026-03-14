-- ╭────────────────────────────────────────────────────────╮
-- │           yanky.nvim - Clipboard Ring Config           │
-- ╰────────────────────────────────────────────────────────╯
-- Auto-indent on paste is handled by <Plug>(Yanky*Filter)
-- mappings in keymaps.lua (executes == after put).

local M = {}

M.opts = {
  ring = {
    history_length = 100,
    storage = "sqlite",
    storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db",
    sync_with_numbered_registers = true,
    cancel_event = "update",
    ignore_registers = { "_", "-", "+", "=" },
    permanent_wrapper = nil,
  },
  picker = {
    select = {
      action = nil,
    },
    telescope = {
      use_default_mappings = true,
      mappings = nil,
    },
  },
  system_clipboard = {
    sync_with_ring = true,
  },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 200,
  },
  preserve_cursor_position = {
    enabled = true,
  },
  textobj = {
    enabled = true,
  },
}

M.setup = function()
  require("yanky").setup(M.opts)
end

return M
