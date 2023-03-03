-- ~/.local/share/nvim/lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  --------------------- colorschemes --------------------
  -- tokyonight
  "folke/tokyonight.nvim",
  -- OceanicNext
  "mhartington/oceanic-next",
  {
    "ellisonleao/gruvbox.nvim",
    dependencies = { "rktjmp/lush.nvim" },
  },
  "olimorris/onedarkpro.nvim",
  "catppuccin/nvim",
  "sainnhe/edge",
  "marko-cerovac/material.nvim",
  "sainnhe/gruvbox-material",
  "glepnir/zephyr-nvim",
  "rebelot/kanagawa.nvim",

  -- nvim-tree
  { "kyazdani42/nvim-tree.lua",  dependencies = "kyazdani42/nvim-web-devicons" },
  -- bufferline
  { "akinsho/bufferline.nvim",   dependencies = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } },
  -- lualine
  { "nvim-lualine/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons" } },
  "arkav/lualine-lsp-progress",

  -- telescope
  { 'nvim-telescope/telescope.nvim',   dependencies = { "nvim-lua/plenary.nvim" } },
  -- telescope extensions
  "LinArcX/telescope-env.nvim",
  "nvim-telescope/telescope-ui-select.nvim",

  -- dashboard-nvim
  "glepnir/dashboard-nvim",
  -- project
  "ahmedkhalf/project.nvim",
  -- treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "lukas-reineke/indent-blankline.nvim",
  "p00f/nvim-ts-rainbow",

  --------------------- LSP --------------------
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  -- 补全引擎
  "hrsh7th/nvim-cmp",
  -- snippet 引擎
  "hrsh7th/vim-vsnip",
  -- 补全源
  "hrsh7th/cmp-vsnip",
  "hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
  "hrsh7th/cmp-buffer", -- { name = 'buffer' },
  "hrsh7th/cmp-path", -- { name = 'path' }
  "hrsh7th/cmp-cmdline", -- { name = 'cmdline' }
  "hrsh7th/cmp-nvim-lsp-signature-help", -- { name = 'nvim_lsp_signature_help' }

  -- 常见编程语言代码段
  "rafamadriz/friendly-snippets",

  -- ui
  "onsails/lspkind-nvim",

  "tami5/lspsaga.nvim",

  -- 代码格式化
  -- "mhartington/formatter.nvim",
  { "jose-elias-alvarez/null-ls.nvim",      dependencies = "nvim-lua/plenary.nvim" },

  -- JSON 增强
  "b0o/schemastore.nvim",

  -- typescript 增强
  { "jose-elias-alvarez/nvim-lsp-ts-utils", dependencies = "nvim-lua/plenary.nvim" },

  -- Rust 增强
  "simrat39/rust-tools.nvim",

  -- surround
  "ur4ltz/surround.nvim",
  -- Comment
  "numToStr/Comment.nvim",
  -- nvim-autopairs
  "windwp/nvim-autopairs",

  "akinsho/toggleterm.nvim",

  "lewis6991/gitsigns.nvim",

  "rmagatti/auto-session",

  {
    'rmagatti/session-lens',
    dependencies = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
  },

  -- "xiyaowong/nvim-transparent",

  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Lua 开发模块
      "BurntSushi/ripgrep" -- 文字查找
    }
  },
  "mg979/vim-visual-multi",

  "norcalli/nvim-colorizer.lua",

  "folke/which-key.nvim",

  "kdheepak/lazygit.nvim",

  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

  "karb94/neoscroll.nvim",

  {
    "phaazon/hop.nvim",
    branch = 'v2', -- optional but strongly recommended
  },

  "lewis6991/spellsitter.nvim",

  "rmagatti/goto-preview",

  "simrat39/symbols-outline.nvim",

  -- "weilbith/nvim-code-action-menu",

  "stevearc/dressing.nvim",

  -- "petertriho/nvim-scrollbar",

  "chentoast/marks.nvim",

  "ThePrimeagen/harpoon",

  "j-hui/fidget.nvim",

  "folke/trouble.nvim",

  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require('crates').setup()
    end,
  },
  { "kevinhwang91/nvim-hlslens",
    config = function()
      require('hlslens').setup()
    end,
  },

  "nvim-telescope/telescope-symbols.nvim",

  "nvim-telescope/telescope-hop.nvim",

  -- winbar
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig"
  },

  {
    "tanvirtin/vgit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  } }
)
