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
    dependencies = { "abeldekat/harpoonline" },
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
  -- │ smart-splits - Intelligent Window Management           │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "mrjones2014/smart-splits.nvim",
    version = "v1.*", -- pin major version
    event = "VeryLazy",
    keys = {
      -- Window Navigation
      { "<leader>wh", function() require("smart-splits").move_cursor_left() end,  desc = "Go Left Window" },
      { "<leader>wj", function() require("smart-splits").move_cursor_down() end,  desc = "Go Down Window" },
      { "<leader>wk", function() require("smart-splits").move_cursor_up() end,    desc = "Go Up Window" },
      { "<leader>wl", function() require("smart-splits").move_cursor_right() end, desc = "Go Right Window" },
      -- Window Resize
      { "<leader>shh", function() require("smart-splits").resize_left() end,  desc = "Window Width -10" },
      { "<leader>sll", function() require("smart-splits").resize_right() end, desc = "Window Width +10" },
      { "<leader>sjj", function() require("smart-splits").resize_down() end, desc = "Window Height +10" },
      { "<leader>skk", function() require("smart-splits").resize_up() end,    desc = "Window Height -10" },
    },
    config = function()
      require("smart-splits").setup(require("plugin-config.smart-splits").opts)
    end,
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
