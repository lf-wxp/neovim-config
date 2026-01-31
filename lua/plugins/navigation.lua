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
    keys = {
      { "<leader>tt", "<cmd>NvimTreeToggle<cr>", desc = "File Tree" },
    },
    config = function()
      require("plugin-config.nvim-tree")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ oil.nvim - Buffer-style File Manager                   │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open Parent Dir (Oil)" },
      { "<leader>-", function() require("oil").toggle_float() end, desc = "Oil Float" },
    },
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
    keys = {
      { "<leader><leader>f", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader><leader>t", "<cmd>Telescope live_grep_args<cr>", desc = "Live Grep" },
      { "<leader><leader>p", "<cmd>Telescope projects<cr>", desc = "Projects" },
      { "<leader><leader>c", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
      { "<leader><leader>e", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "File Browser" },
      { "<leader><leader>k", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader><leader>b", "<cmd>Telescope buffers sort_mru=true<cr>", desc = "Buffers" },
      { "<Tab>", "<cmd>Telescope buffers sort_mru=true<cr>", desc = "Buffers" },
    },
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
    keys = {
      { "<leader>rp", "<cmd>GrugFar<cr>", desc = "Project Search Replace" },
      { "<leader>rf", function() require("grug-far").open({ prefills = { flags = vim.fn.expand("%") } }) end, desc = "Replace in File" },
      { "<leader>rw", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, desc = "Search Word" },
    },
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
