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
      -- Core completion sources
      "hrsh7th/cmp-nvim-lsp",           -- LSP completions
      "hrsh7th/cmp-buffer",             -- Buffer words
      "hrsh7th/cmp-path",               -- File path
      "hrsh7th/cmp-cmdline",            -- Command line
      "dmitmel/cmp-cmdline-history",    -- Command line history
      -- Extended completion sources
      "hrsh7th/cmp-nvim-lua",           -- Neovim Lua API completions
      "hrsh7th/cmp-calc",               -- Math calculation (e.g., 1+1=2)
      "hrsh7th/cmp-emoji",              -- Emoji completions (:smile:)
      "FelipeLema/cmp-async-path",      -- Async path completion (better performance)
      "hrsh7th/cmp-nvim-lsp-signature-help", -- Function signature hints while typing
      "hrsh7th/cmp-nvim-lsp-document-symbol", -- LSP document symbols for /
      -- Frontend completion sources
      "ray-x/cmp-treesitter",           -- Treesitter syntax-aware completions
      "David-Kunz/cmp-npm",             -- NPM package completions for package.json
      "Jezda1337/nvim-html-css",        -- HTML/CSS id and class completions
      -- Git completions
      "petertriho/cmp-git",             -- Git completions (commits, branches, issues, etc.)
      -- Project-wide search
      "lukas-reineke/cmp-rg",           -- Ripgrep source for searching in project
      -- Dictionary and spelling
      "uga-rosa/cmp-dictionary",        -- Dictionary completions for natural language
      -- Clipboard history
      "chrisgrieser/cmp_yanky",         -- Yanky clipboard history completions
      -- Better sorting
      "lukas-reineke/cmp-under-comparator", -- Better sorting for underscore prefixed items
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
      require("plugin-config.nvim-treesitter").setup()
    end,
  },
}
