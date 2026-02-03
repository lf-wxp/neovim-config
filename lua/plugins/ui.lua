-- ╭──────────────────────────────────────────────────────────╮
-- │                      UI Components                        │
-- ╰──────────────────────────────────────────────────────────╯

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ bufferline - Tab Bar                                   │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "moll/vim-bbye" },
    event = "VeryLazy",
    keys = {
      { "<leader>h",   "<cmd>BufferLineCyclePrev<cr>",  desc = "Prev Tab" },
      { "<leader>l",   "<cmd>BufferLineCycleNext<cr>",  desc = "Next Tab" },
      { "<leader><",   "<cmd>BufferLineMovePrev<cr>",   desc = "Move Tab Left" },
      { "<leader>>",   "<cmd>BufferLineMoveNext<cr>",   desc = "Move Tab Right" },
      { "<leader>tp",  "<cmd>BufferLinePick<cr>",       desc = "Pick Tab" },
      { "<leader>tc",  "<cmd>Bdelete!<cr>",             desc = "Close Tab" },
      { "<leader>bcl", "<cmd>BufferLineCloseRight<cr>", desc = "Close Right Tabs" },
      { "<leader>bch", "<cmd>BufferLineCloseLeft<cr>",  desc = "Close Left Tabs" },
      { "<leader>bc",  "<cmd>BufferLinePickClose<cr>",  desc = "Pick Close Tab" },
    },
    config = function()
      require("bufferline").setup(require("plugin-config.bufferline").opts)
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ lualine - Status Line                                  │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "abeldekat/harpoonline" },
    event = "VeryLazy",
    config = function()
      require("plugin-config.lualine")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ noice - Cmdline/Notify/Search UI                       │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("noice").setup(require("plugin-config.noice").opts)
    end,
  },
  -- ╭────────────────────────────────────────────────────────╮
  -- │ which-key - Keymap Hints                               │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.icons", version = false },
    config = function()
      require("plugin-config.which-key")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ snacks.nvim - Multi-purpose                            │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      { "<leader>;",  function() Snacks.dashboard() end,       desc = "Dashboard" },
      { "<leader>bd", function() Snacks.bufdelete() end,       desc = "Delete Buffer" },
      { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
      { "<c-_>",      function() Snacks.terminal() end,        mode = { "n", "t" },          desc = "Terminal" },
      { "<c-/>",      function() Snacks.terminal() end,        mode = { "n", "t" },          desc = "Terminal" },
    },
    opts = require("plugin-config.snacks").opts,
    config = function(_, opts)
      require("snacks").setup(opts)
      require("plugin-config.snacks").init()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ dropbar - Breadcrumb Navigation                        │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "Bekaboo/dropbar.nvim",
    event = "BufReadPost",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugin-config.dropbar")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-highlight-colors - Color Highlight                │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPost",
    opts = {
      render = "virtual",
      virtual_symbol = "▣",
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ colorful-winsep - Window Separator                     │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "nvim-zh/colorful-winsep.nvim",
    event = "WinLeave",
    config = true,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ tiny-glimmer - Cursor Effects                          │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    priority = 10,
    config = function()
      require("plugin-config.tiny-glimmer")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ reactive - Mode Cursor Style                           │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "rasulomaroff/reactive.nvim",
    event = "VeryLazy",
    config = function()
      require("plugin-config.reactive")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ helpview/markview - Help/Markdown Render               │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "OXY2DEV/helpview.nvim",
    ft = "help",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ log-highlight - Log Highlight                          │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "fei6409/log-highlight.nvim",
    ft = "log",
    opts = {},
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ cellular-automaton - Fun Plugin                        │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
  },
}
