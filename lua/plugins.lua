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
  "glepnir/zephyr-nvim",
  { "ellisonleao/gruvbox.nvim", priority = 1000 },
  "rebelot/kanagawa.nvim",
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons", "b0o/nvim-tree-preview.lua" },
    config = function()
      require("plugin-config.nvim-tree")
    end
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "moll/vim-bbye" },
    config = function()
      require("plugin-config.bufferline")
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "abeldekat/harpoonline" },
    config = function()
      require("plugin-config.lualine")
    end
  },
  -- "arkav/lualine-lsp-progress",

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugin-config.telescope")
    end
  },
  -- telescope extensions
  "LinArcX/telescope-env.nvim",
  "nvim-telescope/telescope-ui-select.nvim",
  "nvim-telescope/telescope-symbols.nvim",
  "nvim-telescope/telescope-live-grep-args.nvim",

  {
    "glepnir/dashboard-nvim",
    config = function()
      require("plugin-config.dashboard")
    end
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugin-config.project")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
      -- "nvim-treesitter/nvim-treesitter-refactor", // cause crush
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
      require("plugin-config.nvim-treesitter")
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = "HiPhish/rainbow-delimiters.nvim",
    opts = {},
    config = function()
      require("plugin-config.indent-blankline")
    end
  },

  --------------------- LSP --------------------
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } }
      }
    },
  },


  -- 补全引擎
  "hrsh7th/nvim-cmp",
  -- snippet 引擎
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  -- 补全源
  "hrsh7th/cmp-vsnip",
  "hrsh7th/cmp-nvim-lsp",                -- { name = nvim_lsp }
  "hrsh7th/cmp-buffer",                  -- { name = "buffer" },
  "hrsh7th/cmp-path",                    -- { name = "path" }
  "hrsh7th/cmp-cmdline",                 -- { name = "cmdline" }
  "hrsh7th/cmp-nvim-lsp-signature-help", -- { name = "nvim_lsp_signature_help" }

  -- 常见编程语言代码段
  "rafamadriz/friendly-snippets",

  -- ui
  "onsails/lspkind-nvim",
  "nvimdev/lspsaga.nvim",

  -- 代码格式化
  -- "mhartington/formatter.nvim",
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim", "davidmh/cspell.nvim" }
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-null-ls").setup() -- require your null-ls config here (example below)
    end,
  },
  {
    "stevearc/conform.nvim",
  },

  -- JSON 增强
  "b0o/schemastore.nvim",

  -- Rust 增强
  {
    "mrcjkb/rustaceanvim",
    version = "^3", -- Recommended
    ft = { "rust" },
  },

  -- Lua 增强
  "folke/neodev.nvim",

  {
    "kylechui/nvim-surround",
    config = function()
      require("plugin-config.nvim-surround")
    end
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("plugin-config.comment")
    end
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugin-config.nvim-autopairs")
    end
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("plugin-config.toggleterm")
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugin-config.gitsigns")
    end
  },
  {
    "rmagatti/auto-session",
    config = function()
      require("plugin-config.auto-session")
    end
  },
  -- {
  --   "nvim-pack/nvim-spectre",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim", -- Lua 开发模块
  --   },
  -- },
  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    opts = {},     -- This causes the plugin setup function to be called
  },

  -- {
  --   "norcalli/nvim-colorizer.lua",
  --   config = function()
  --     require("colorizer").setup()
  --   end
  -- },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "virtual",
        virtual_symbol = "▣",
      })
    end
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.icons", version = false },
    config = function()
      require("plugin-config.which-key")
    end
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugin-config.diffview")
    end
  },

  {
    "karb94/neoscroll.nvim",
    config = function()
      require("plugin-config.neoscroll")
    end
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("plugin-config.flash")
    end
  },

  {
    "rmagatti/goto-preview",
    dependencies = { "rmagatti/logger.nvim" },
    event = "BufEnter",
    config = function()
      require("plugin-config.goto-preview")
    end
  },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup()
    end
  },

  {
    "chentoast/marks.nvim",
    config = function()
      require("plugin-config.marks")
    end
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
      require("plugin-config.harpoon")
    end
  },

  {
    "j-hui/fidget.nvim",
    -- tag = "legacy",
    config = function()
      require("plugin-config.fidget")
    end
  },

  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end
  },

  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
    end,
  },

  -- {
  --   "SmiteshP/nvim-navic",
  --   dependencies = "neovim/nvim-lspconfig"
  -- },

  {
    "anuvyklack/pretty-fold.nvim",
    config = function()
      require("pretty-fold").setup()
    end,
  },

  {
    "anuvyklack/fold-preview.nvim",
    dependencies = "anuvyklack/keymap-amend.nvim",
    config = function()
      require("plugin-config.fold-preview")
    end,
  },

  {
    "tanvirtin/vgit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("vgit").setup()
    end,
  },
  {
    "michaelb/sniprun",
    build = "sh ./install.sh"
  },
  -- {
  --   "m4xshen/hardtime.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {
  --     restriction_mode = "hint",
  --     disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil", },
  --     disabled_keys = {
  --       ["<Up>"] = {},
  --       ["<Down>"] = {},
  --       ["<Left>"] = {},
  --       ["<Right>"] = {},
  --     },
  --   },
  -- },
  {
    "roobert/surround-ui.nvim",
    dependencies =
    "kylechui/nvim-surround",
    config = function()
      require("surround-ui").setup({
        root_key = "S"
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
    },
    config = function()
      require("plugin-config.noice")
    end,
  },
  {
    "eandrju/cellular-automaton.nvim"
  },
  -- {
  --   "tamton-aquib/zone.nvim",
  --   config = function()
  --     require("plugin-config.zone")
  --   end,
  -- },
  -- {
  --   "giusgad/pets.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
  --   config = function()
  --     require("pets").setup()
  --   end,
  -- },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {},
  },
  {
    "j-morano/buffer_manager.nvim",
    config = function()
      require("buffer_manager").setup({
        width = 100,
        height = 20,
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      })
    end,
  },
  {
    "rasulomaroff/reactive.nvim",
    config = function()
      require("reactive").setup({
        builtin = {
          -- cursorline = true,
          cursor = true,
          modemsg = true
        }
      })
    end,
  },
  {
    "aznhe21/actions-preview.nvim",
    config = function()
      require("plugin-config.actions-preview")
    end,
  },
  -- {
  --   "mawkler/modicator.nvim",
  --   dependencies = "glepnir/zephyr-nvim",
  --   opts = {}
  -- }
  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    opts = {
      bind = true,
      handler_opts = {
        border = "solid"
      }
    },
  },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  },
  {
    "MagicDuck/grug-far.nvim",
    event = "VeryLazy",
    config = function()
      require("grug-far").setup({
        keymaps = {
          toggleShowCommand = { n = "<localleader>m" },
        },
      });
    end
  },
  { "catppuccin/nvim",          name = "catppuccin", priority = 1000 },
  {
    "OXY2DEV/helpview.nvim",
    lazy = false, -- Recommended
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      require("plugin-config.neogit")
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("plugin-config.codecompanion")
    end,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
    end,
  },
  {
    "chrisgrieser/nvim-recorder",
    opts = {},
  },
  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    priority = 10, -- Needs to be a really low priority, to catch others plugins keybindings.
    config = function()
      require("plugin-config.tiny-glimmer")
    end,
  },
  { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   opts = {},
  -- },
  {
    'm-demare/hlargs.nvim',
    config = function()
      require("hlargs").setup({
        color = Hlargs,     -- You can change this to any color you like
        hl_priority = 1000, -- Set the highlight priority
      })
    end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinLeave" },
  },
  {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
      require("plugin-config.symbol-usage")
    end
  }
})
