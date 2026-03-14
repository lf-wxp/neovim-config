-- ╭────────────────────────────────────────────────────────╮
-- │                  Navigation Plugins                    │
-- ╰────────────────────────────────────────────────────────╯

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-tree - File Tree                                  │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons", "b0o/nvim-tree-preview.lua" },
    keys = function()
      local keys = require("config.keymaps").nvimTree
      return {
        { keys.toggle, "<cmd>NvimTreeToggle<cr>", desc = "File Tree" },
      }
    end,
    config = function()
      require("plugin-config.nvim-tree").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ oil.nvim - Buffer-style File Manager                   │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "stevearc/oil.nvim",
    keys = function()
      local keys = require("config.keymaps").oil
      return {
        { keys.open, "<cmd>Oil<cr>", desc = "Open Parent Dir (Oil)" },
        { keys.open_float, function() require("oil").toggle_float() end, desc = "Oil Float" },
      }
    end,
    config = function()
      require("plugin-config.oil").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ telescope - Fuzzy Finder                               │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "LinArcX/telescope-env.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      -- fzf-native 提供高性能原生 fzf 排序器，显著加速模糊搜索
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = function()
      local keys = require("config.keymaps").telescope
      return {
        { keys.find_files, "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { keys.live_grep, "<cmd>Telescope live_grep_args<cr>", desc = "Live Grep" },
        { keys.projects, "<cmd>Telescope projects<cr>", desc = "Projects" },
        { keys.colorscheme, "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
        { keys.file_browser, "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "File Browser" },
        { keys.keymaps, "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
        { keys.buffers, "<cmd>Telescope buffers sort_mru=true<cr>", desc = "Buffers" },
        { keys.buffers_tab, "<cmd>Telescope buffers sort_mru=true<cr>", desc = "Buffers" },
      }
    end,
    config = function()
      require("plugin-config.telescope").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ project.nvim - Project Management                      │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "ahmedkhalf/project.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("plugin-config.project").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ harpoon - Quick File Switch                            │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    keys = function()
      local keys = require("config.keymaps").harpoon
      return {
        { keys.append, function() require("harpoon"):list():add() end, desc = "Harpoon Add" },
        { keys.toggle, function() require("config.commands").harpoon_toggle() end, desc = "Harpoon Toggle" },
        { keys.prev, function() require("harpoon"):list():prev() end, desc = "Harpoon Prev" },
        { keys.next, function() require("harpoon"):list():next() end, desc = "Harpoon Next" },
        { keys.n1, function() require("harpoon"):list():select(1) end, desc = "Harpoon File 1" },
        { keys.n2, function() require("harpoon"):list():select(2) end, desc = "Harpoon File 2" },
        { keys.n3, function() require("harpoon"):list():select(3) end, desc = "Harpoon File 3" },
        { keys.n4, function() require("harpoon"):list():select(4) end, desc = "Harpoon File 4" },
        { keys.n5, function() require("harpoon"):list():select(5) end, desc = "Harpoon File 5" },
        { keys.n6, function() require("harpoon"):list():select(6) end, desc = "Harpoon File 6" },
        { keys.telescope, function() require("config.commands").harpoon_telescope() end, desc = "Harpoon Telescope" },
      }
    end,
    config = function()
      require("plugin-config.harpoon").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ trouble - Diagnostics List                             │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = function()
      local keys = require("config.keymaps").trouble
      return {
        { keys.toggle, "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
        { keys.diagnostics, "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
        { keys.symbols, "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
        { keys.lsp_references, "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP References" },
        { keys.loclist, "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
        { keys.quickfix, "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
      }
    end,
    opts = {},
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ grug-far - Project Search Replace                      │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "MagicDuck/grug-far.nvim",
    keys = function()
      local keys = require("config.keymaps").grugFar
      return {
        { keys.project, function() require("config.commands").grug_far() end, desc = "Project Search Replace" },
        { keys.file, function() require("config.commands").grug_far_file() end, desc = "Replace in File" },
        { keys.word, function() require("config.commands").grug_far_word() end, desc = "Search Word" },
      }
    end,
    opts = {
      keymaps = {
        toggleShowCommand = { n = "<localleader>m" },
      },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ aerial.nvim - Symbol Navigation (Float Window)         │
  -- │ Replaces navbuddy+navic with zero extra dependencies   │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = function()
      local keys = require("config.keymaps").aerial
      return {
        { keys.nav_toggle, "<cmd>AerialNavToggle<cr>", desc = "Symbol Navigation (Aerial Float)" },
        { keys.toggle, "<cmd>AerialToggle<cr>", desc = "Symbol Outline (Aerial)" },
      }
    end,
    opts = {
      backends = { "lsp", "treesitter", "markdown", "man" },
      layout = {
        default_direction = "prefer_right",
        placement = "edge",
      },
      float = {
        border = "none",
        relative = "win",
        override = function(conf, source_winid)
          -- 四周 padding：左右各 2 列，上下各 2 行
          conf.col = 2
          conf.row = 2
          conf.width = conf.width and (conf.width - 4) or nil
          conf.height = conf.height and (conf.height - 4) or nil
          return conf
        end,
      },
      nav = {
        border = "none",
        preview = true,
        win_opts = {
          -- signcolumn 作为左侧 padding
          signcolumn = "yes",
          cursorline = true,
        },
        override = function(conf)
          -- 上下各留 2 行 padding
          conf.row = conf.row and (conf.row + 2) or 2
          conf.height = conf.height and (conf.height - 4) or nil
          return conf
        end,
      },
      show_guides = true,
      filter_kind = false, -- Show all symbol kinds
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ auto-session - Session Management                      │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "rmagatti/auto-session",
    lazy = false,  -- Load immediately to enable auto-restore
    config = function()
      require("plugin-config.auto-session").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ store.nvim - Note Storage                              │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "alex-popov-tech/store.nvim",
    cmd = "Store",
  },
}
