-- ╭────────────────────────────────────────────────────────╮
-- │ Completion and Snippets                                │
-- ╰────────────────────────────────────────────────────────╯

return {
  -- ╭─────────────────────────────────────────────────────╮
  -- │ blink.cmp - Completion Engine (replaces nvim-cmp)   │
  -- ╰─────────────────────────────────────────────────────╯
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      -- Snippet engine
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      -- Compatibility layer: bridge nvim-cmp sources to blink.cmp
      "saghen/blink.compat",
      -- Native blink community sources
      "moyiz/blink-emoji.nvim",
      "Kaiser-Yang/blink-cmp-git",
      -- nvim-cmp sources bridged via blink.compat
      "ray-x/cmp-treesitter",
      "David-Kunz/cmp-npm",
      "hrsh7th/cmp-calc",
      "uga-rosa/cmp-dictionary",
      "chrisgrieser/cmp_yanky",
      "Jezda1337/nvim-html-css",
      "dmitmel/cmp-cmdline-history",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "lukas-reineke/cmp-rg",
      -- lazydev (Lua API completion, native blink.cmp support)
      "folke/lazydev.nvim",
    },
    config = function()
      require("blink-cmp.setup")
    end,
  },

  -- ╭─────────────────────────────────────────────────────╮
  -- │ blink.compat - nvim-cmp Source Compatibility Layer  │
  -- ╰─────────────────────────────────────────────────────╯
  {
    "saghen/blink.compat",
    version = "2.*",
    lazy = true,
    opts = {},
  },

  -- ╭─────────────────────────────────────────────────────╮
  -- │ LuaSnip - Snippet Engine                            │
  -- ╰─────────────────────────────────────────────────────╯
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("plugin-config.luasnip").setup()
    end,
  },

  -- ╭─────────────────────────────────────────────────────╮
  -- │ rainbow-delimiters.nvim - Rainbow Brackets          │
  -- ╰─────────────────────────────────────────────────────╯
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local rainbow = require("rainbow-delimiters")
      ---@type rainbow_delimiters.config
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow.strategy["global"],
          vim = rainbow.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- ╭─────────────────────────────────────────────────────╮
  -- │ nvim-treesitter - Syntax Highlighting               │
  -- ╰─────────────────────────────────────────────────────╯
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
      require("plugin-config.nvim-treesitter").setup()
    end,
  },
}
