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
      require("plugin-config.nvim-tree")
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
      require("plugin-config.oil")
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
      require("plugin-config.telescope")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ project.nvim - Project Management                      │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("plugin-config.project")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ harpoon - Quick File Switch                            │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",
    config = function()
      require("plugin-config.harpoon")
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
    lazy = false,
    config = function()
      require("plugin-config.auto-session")
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
