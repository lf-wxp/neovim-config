-- ╭────────────────────────────────────────────────────────╮
-- │     tiny-glimmer.nvim - Cursor Effects Config          │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  require("tiny-glimmer").setup({
    overwrite = {
      search = {
        enabled = true,
        default_animation = "pulse",
      },
      undo = {
        enabled = true,
      },
      redo = {
        enabled = true,
      }
    }
  })
end

return M
