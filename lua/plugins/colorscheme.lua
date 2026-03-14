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
      -- 注册 autocmd 以在切换 colorscheme 时重新应用 highlights
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
