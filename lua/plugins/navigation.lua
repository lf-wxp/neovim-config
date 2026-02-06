-- ╭──────────────────────────────────────────────────────────╮
-- │                      Navigation Plugins                   │
-- ╰──────────────────────────────────────────────────────────╯

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
        { keys.open_float, "<cmd>lua require('config.commands').oil_float()<cr>", desc = "Oil Float" },
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
    event = "VeryLazy",
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
    event = "VeryLazy",
    keys = function()
      local keys = require("config.keymaps").harpoon
      return {
        { keys.append, "<cmd>lua require('config.commands').harpoon_add()<cr>", desc = "Harpoon Add" },
        { keys.toggle, "<cmd>lua require('config.commands').harpoon_toggle()<cr>", desc = "Harpoon Toggle" },
        { keys.prev, "<cmd>lua require('config.commands').harpoon_prev()<cr>", desc = "Harpoon Prev" },
        { keys.next, "<cmd>lua require('config.commands').harpoon_next()<cr>", desc = "Harpoon Next" },
        { keys.n1, "<cmd>lua require('config.commands').harpoon_select(1)<cr>", desc = "Harpoon File 1" },
        { keys.n2, "<cmd>lua require('config.commands').harpoon_select(2)<cr>", desc = "Harpoon File 2" },
        { keys.n3, "<cmd>lua require('config.commands').harpoon_select(3)<cr>", desc = "Harpoon File 3" },
        { keys.n4, "<cmd>lua require('config.commands').harpoon_select(4)<cr>", desc = "Harpoon File 4" },
        { keys.n5, "<cmd>lua require('config.commands').harpoon_select(5)<cr>", desc = "Harpoon File 5" },
        { keys.n6, "<cmd>lua require('config.commands').harpoon_select(6)<cr>", desc = "Harpoon File 6" },
        { keys.telescope, "<cmd>lua require('config.commands').harpoon_telescope()<cr>", desc = "Harpoon Telescope" },
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
        { keys.project, "<cmd>GrugFar<cr>", desc = "Project Search Replace" },
        { keys.file, "<cmd>lua require('config.commands').grug_far_file()<cr>", desc = "Replace in File" },
        { keys.word, "<cmd>lua require('config.commands').grug_far_word()<cr>", desc = "Search Word" },
      }
    end,
    opts = {
      keymaps = {
        toggleShowCommand = { n = "<localleader>m" },
      },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-navbuddy - Symbol Navigation                      │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = { "MunifTanjim/nui.nvim", "SmiteshP/nvim-navic" },
    opts = {
      lsp = { auto_attach = true },
      window = { border = "none" },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ auto-session - Session Management                      │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "rmagatti/auto-session",
    lazy = false,  -- 立即加载以启用自动恢复
    config = function()
      require("plugin-config.auto-session").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ store.nvim - Note Storage                              │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "alex-popov-tech/store.nvim",
    dependencies = { "OXY2DEV/markview.nvim" },
    cmd = "Store",
  },
}
