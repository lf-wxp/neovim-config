-- ╭────────────────────────────────────────────────────────╮
-- │           yanky.nvim - Clipboard Ring Config           │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.opts = {
  ring = {
    history_length = 100,
    storage = "shada",
    sync_with_numbered_registers = true,
    cancel_event = "update",
    ignore_registers = { "_", "-", "+", "=" },
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
