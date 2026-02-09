-- ╭────────────────────────────────────────────────────────╮
-- │        harpoon - File Navigation Configuration         │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  require("harpoon"):setup({
    settings = {
      save_on_toggle = true,
      sync_on_ui_close = true,
    },
  })
end

return M
