-- ~/.local/share/nvim/lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

  -- project.nvim - 项目管理
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugin-config.project")
    end,
  },

  -- ts-comments.nvim - 更好的注释支持
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
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
    "neovim/nvim-lspconfig",


  -- 补全引擎
  "hrsh7th/nvim-cmp",
  -- snippet 引擎
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  -- 补全源
  -- "hrsh7th/cmp-vsnip",
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
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "kylechui/nvim-surround",
    config = function()
      require("plugin-config.nvim-surround")
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
    lazy = false,
    config = function()
      require("plugin-config.auto-session")
    end
  },
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
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },  -- 懒加载
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugin-config.diffview")
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
    "chentoast/marks.nvim",
    event = "BufReadPost",  -- 懒加载，读取文件后加载
    config = function()
      require("plugin-config.marks")
    end
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",  -- 懒加载
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
    cmd = "Trouble",  -- 懒加载
    config = function()
      require("trouble").setup()
    end
  },

  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("crates").setup()
    end,
  },

    {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "SmiteshP/nvim-navic",
    },
    opts = {
      lsp = { auto_attach = true },
      window = { border = "none" },
    },
  },

  {
    "chrisgrieser/nvim-origami",
    event = "BufReadPost",
    config = function()
      require("plugin-config.origami")
    end,
  },

  {
    "michaelb/sniprun",
    build = "sh ./install.sh",
    cmd = { "SnipRun", "SnipRunOperator", "SnipInfo" },  -- 懒加载
    config = function()
      require("plugin-config.sniprun")
    end,
  },
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
  -- cellular-automaton.nvim 娱乐插件已移除
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",  -- 仅在调用命令时加载
    config = function()
      require("grug-far").setup({
        keymaps = {
          toggleShowCommand = { n = "<localleader>m" },
        },
      })
    end
  },
  { "catppuccin/nvim",          name = "catppuccin", priority = 1000 },
  {
    "OXY2DEV/helpview.nvim",
    ft = "help",  -- 懒加载，仅在打开帮助文件时加载
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",  -- 懒加载，仅在打开 markdown 文件时加载
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",  -- 懒加载，仅在调用命令时加载
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
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionToggle", "CodeCompanionActions" },  -- 懒加载
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
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },  -- 懒加载
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
  -- snacks.nvim - 多功能集成插件
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = require("plugin-config.snacks").opts,
  },

  -- oil.nvim - 以 buffer 方式编辑文件系统
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugin-config.oil")
    end,
  },

  -- mini.ai - 增强文本对象
  {
    "echasnovski/mini.ai",
    version = "*",
    config = function()
      require("mini.ai").setup()
    end,
  },
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
  },
  {
    'fei6409/log-highlight.nvim',
    opts = {},
  },

  {
    "alex-popov-tech/store.nvim",
    dependencies = { "OXY2DEV/markview.nvim" },
    cmd = "Store"
  },
  {
    "XXiaoA/atone.nvim",
    cmd = "Atone",
    opts = {}, -- your configuration here
  },
  -- With lazy.nvim
  {
    "alexpasmantier/krust.nvim",
    ft = "rust",
    opts = {
      keymap = "<leader><leader>r", -- Set a keymap for Rust buffers (default: false)
      float_win = {
        border = "none",            -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
        auto_focus = false,         -- Auto-focus float (default: false)
      },
    },
  },
  {
    name = "CodeBuddy",
    url = "git@git.woa.com:felikszhou/gongfeng-operation-platform.git",
    lazy = true,
    event = "InsertEnter",
    cmd = "CodeBuddy",
  },
  {
    "andersevenrud/nvim_context_vt",
    event = "BufReadPost",  -- 懒加载
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
    },
    opts = {
      -- 禁用内置 LSP 设置，使用 lsp/setup.lua 中的 tailwindcss 配置
      server = {
        override = false, -- 不覆盖 LSP 配置
      },
    },
  },
  {
    "gregorias/coerce.nvim",
    config = true,
  },
  -- dropbar.nvim - 面包屑导航 (类似 VS Code)
  {
    "Bekaboo/dropbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugin-config.dropbar")
    end,
  },
  -- jake-stewart/multicursor.nvim 更好的多光标体验
  {
    "jake-stewart/multicursor.nvim",
    branch = "main",
    event = "VeryLazy",
    config = function()
      require("plugin-config.multicursor")
    end,
  },

  -- reactive.nvim - 根据编辑模式动态改变光标/cursorline样式
  {
    "rasulomaroff/reactive.nvim",
    event = "VeryLazy",
    config = function()
      require("plugin-config.reactive")
    end,
  },

  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",  -- 懒加载，仅在调用命令时加载
  },
})
