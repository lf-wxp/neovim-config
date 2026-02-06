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
    keys = function()
      local keys = require("config.keymaps").bufferline
      return {
        { keys.prev_tab,   "<cmd>BufferLineCyclePrev<cr>",  desc = "Prev Tab" },
        { keys.next_tab,   "<cmd>BufferLineCycleNext<cr>",  desc = "Next Tab" },
        { keys.move_prev,   "<cmd>BufferLineMovePrev<cr>",   desc = "Move Tab Left" },
        { keys.move_next,   "<cmd>BufferLineMoveNext<cr>",   desc = "Move Tab Right" },
        { keys.pick,  "<cmd>BufferLinePick<cr>",       desc = "Pick Tab" },
        { keys.close,  "<cmd>Bdelete!<cr>",             desc = "Close Tab" },
        { keys.close_right, "<cmd>BufferLineCloseRight<cr>", desc = "Close Right Tabs" },
        { keys.close_left, "<cmd>BufferLineCloseLeft<cr>",  desc = "Close Left Tabs" },
        { keys.pick_close,  "<cmd>BufferLinePickClose<cr>",  desc = "Pick Close Tab" },
      }
    end,
    config = function()
      require("plugin-config.bufferline").setup()
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
      require("plugin-config.lualine").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ noice - Cmdline/Notify/Search UI                       │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "folke/noice.nvim",
    event = "CmdlineEnter",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("plugin-config.noice").setup()
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
      require("plugin-config.which-key").setup()
    end,
  },

-- ╭────────────────────────────────────────────────────────╮
-- │ snacks.nvim - Multi-purpose                            │
-- ╰────────────────────────────────────────────────────────╯
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = function()
      local keys = require("config.keymaps").snacks
      return {
        { keys.dashboard, "<cmd>lua require('config.commands').dashboard()<cr>",       desc = "Dashboard" },
        { keys.bufdelete, "<cmd>lua require('config.commands').bufdelete()<cr>",       desc = "Delete Buffer" },
        { keys.bufdelete_other, "<cmd>lua require('config.commands').bufdelete_other()<cr>", desc = "Delete Other Buffers" },
        { keys.terminal, "<cmd>lua require('config.commands').terminal()<cr>",        mode = { "n", "t" }, desc = "Terminal" },
        { "<leader>tf", "<cmd>lua require('config.commands').terminal_float()<cr>",  mode = { "n", "t" }, desc = "Float Terminal" },
        { "<leader>tr", "<cmd>lua require('config.commands').terminal_right()<cr>",  mode = { "n", "t" }, desc = "Right Terminal" },
        { "<leader>td", "<cmd>lua require('config.commands').terminal_bottom()<cr>", mode = { "n", "t" }, desc = "Bottom Terminal" },
      }
    end,
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
      require("plugin-config.dropbar").setup()
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
    keys = function()
      local keys = require("config.keymaps").smartSplits
      return {
        -- Window Navigation
        { keys.move_left, function() require("smart-splits").move_cursor_left() end,  desc = "Go Left Window" },
        { keys.move_down, function() require("smart-splits").move_cursor_down() end,  desc = "Go Down Window" },
        { keys.move_up, function() require("smart-splits").move_cursor_up() end,    desc = "Go Up Window" },
        { keys.move_right, function() require("smart-splits").move_cursor_right() end, desc = "Go Right Window" },
        -- Window Resize
        { keys.resize_left, function() require("smart-splits").resize_left() end,  desc = "Window Width -10" },
        { keys.resize_right, function() require("smart-splits").resize_right() end, desc = "Window Width +10" },
        { keys.resize_down, function() require("smart-splits").resize_down() end, desc = "Window Height +10" },
        { keys.resize_up, function() require("smart-splits").resize_up() end,    desc = "Window Height -10" },
      }
    end,
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
      require("plugin-config.tiny-glimmer").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ reactive - Mode Cursor Style                           │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "rasulomaroff/reactive.nvim",
    event = "VeryLazy",
    config = function()
      require("plugin-config.reactive").setup()
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
