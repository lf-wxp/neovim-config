-- ╭────────────────────────────────────────────────────────╮
-- │                    Colorscheme                         │
-- ╰────────────────────────────────────────────────────────╯

-- ╭────────────────────────────────────────────────────────╮
-- │                    Plugin Config                       │
-- ╰────────────────────────────────────────────────────────╯

return {
  -- Primary colorscheme
  {
    "glepnir/zephyr-nvim",
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
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
}
