-- ╭──────────────────────────────────────────────────────────╮
-- │                      Completion and Snippets              │
-- ╰──────────────────────────────────────────────────────────╯

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-cmp - Completion Engine                           │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      -- Snippet engine
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      -- Completion sources
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      -- Common language snippets
      "rafamadriz/friendly-snippets",
      -- UI
      "onsails/lspkind-nvim",
    },
    config = function()
      require("cmp.setup")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ LuaSnip - Snippet Engine                               │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("cmp.luasnip")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-treesitter - Syntax Highlighting                  │
  -- ╰────────────────────────────────────────────────────────╯
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
      require("plugin-config.nvim-treesitter")
    end,
  },
}
