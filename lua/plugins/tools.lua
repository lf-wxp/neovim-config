-- ╭──────────────────────────────────────────────────────────╮
-- │                      Terminal and Tools                   │
-- ╰──────────────────────────────────────────────────────────╯

local keys = require("config.keymaps")

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ toggleterm - Terminal Management                       │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { keys.toggleTerm.float, desc = "Float Terminal" },
      { keys.toggleTerm.right, desc = "Right Terminal" },
      { keys.toggleTerm.bottom, desc = "Bottom Terminal" },
    },
    config = function()
      require("plugin-config.toggleterm")
    end,
  },
}
