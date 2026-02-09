-- ╭────────────────────────────────────────────────────────╮
-- │         reactive.nvim - Mode Cursor Style Config       │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  require("reactive").setup({
    builtin = {
      cursorline = false,
      cursor = true,
      modemsg = true,
    },
  })
end

return M
