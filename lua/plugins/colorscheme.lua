-- ╭────────────────────────────────────────────────────────╮
-- │                    Colorscheme                         │
-- ╰────────────────────────────────────────────────────────╯

-- ╭────────────────────────────────────────────────────────╮
-- │                    Plugin Config                       │
-- ╰────────────────────────────────────────────────────────╯

local toggle = require("config.plugin-toggle")

return {
  -- Primary colorscheme
  {
    "glepnir/zephyr-nvim",
    enabled = toggle.is_enabled("zephyr"),
    lazy = false,
    priority = 1000,
    config = function()
      local highlights = require("plugin-config.highlights")
      -- Register autocmd to re-apply highlights when colorscheme changes
      highlights.register_autocmds()
      vim.cmd.colorscheme("zephyr")
      highlights.setup()
    end,
  },

  -- Alternative colorschemes
  { "ellisonleao/gruvbox.nvim", enabled = toggle.is_enabled("gruvbox"), lazy = true },
  { "rebelot/kanagawa.nvim", enabled = toggle.is_enabled("kanagawa"), lazy = true },
  { "catppuccin/nvim", name = "catppuccin", enabled = toggle.is_enabled("catppuccin"), lazy = true },
}
