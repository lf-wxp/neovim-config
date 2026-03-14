-- ╭────────────────────────────────────────────────────────╮
-- │                   UI Components                        │
-- ╰────────────────────────────────────────────────────────╯

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
        { keys.prev_tab,    "<cmd>BufferLineCyclePrev<cr>",  desc = "Prev Tab" },
        { keys.next_tab,    "<cmd>BufferLineCycleNext<cr>",  desc = "Next Tab" },
        { keys.move_prev,   "<cmd>BufferLineMovePrev<cr>",   desc = "Move Tab Left" },
        { keys.move_next,   "<cmd>BufferLineMoveNext<cr>",   desc = "Move Tab Right" },
        { keys.pick,        "<cmd>BufferLinePick<cr>",       desc = "Pick Tab" },
        { keys.close,       "<cmd>Bdelete!<cr>",             desc = "Close Tab" },
        { keys.close_right, "<cmd>BufferLineCloseRight<cr>", desc = "Close Right Tabs" },
        { keys.close_left,  "<cmd>BufferLineCloseLeft<cr>",  desc = "Close Left Tabs" },
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
    event = "VeryLazy",  -- Load on VeryLazy to capture all cmdline/message events
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
      local cmds = require("config.commands")
      return {
        { keys.dashboard,       function() cmds.dashboard() end,       desc = "Dashboard" },
        { keys.bufdelete,       function() cmds.bufdelete() end,       desc = "Delete Buffer" },
        { keys.bufdelete_other, function() cmds.bufdelete_other() end, desc = "Delete Other Buffers" },
        { keys.terminal,        function() cmds.terminal() end,        mode = { "n", "t" }, desc = "Terminal" },
        { keys.terminal_float,  function() cmds.terminal_float() end,  mode = { "n", "t" }, desc = "Float Terminal" },
        { keys.terminal_right,  function() cmds.terminal_right() end,  mode = { "n", "t" }, desc = "Right Terminal" },
        { keys.terminal_bottom, function() cmds.terminal_bottom() end, mode = { "n", "t" }, desc = "Bottom Terminal" },
      }
    end,
    opts = require("plugin-config.snacks").opts,
    config = function(_, opts)
      require("snacks").setup(opts)
      require("plugin-config.snacks").setup_init()
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
  -- │ ccc.nvim - Color Picker & Highlighter                  │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "uga-rosa/ccc.nvim",
    cmd = { "CccPick", "CccConvert" },
    keys = function()
      local keys = require("config.keymaps").ccc
      return {
        { keys.pick, "<cmd>CccPick<cr>", desc = "Color Picker" },
        { keys.convert, "<cmd>CccConvert<cr>", desc = "Convert Color Format" },
      }
    end,
    opts = {
      -- highlighter 功能由 nvim-highlight-colors 统一处理，ccc 仅负责拾取/转换
      default_color = "#000000",
      bar_char = "█",
      point_char = "◇",
      bar_len = 30,
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ smart-splits - Intelligent Window Management           │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "mrjones2014/smart-splits.nvim",
    -- 移除冗余的 event = "VeryLazy"：已有 keys 定义，按键触发时才加载，延迟到真正使用
    keys = function()
      local keys = require("config.keymaps").smartSplits
      return {
        -- Window Navigation
        { keys.move_left,    function() require("smart-splits").move_cursor_left() end,  desc = "Go Left Window" },
        { keys.move_down,    function() require("smart-splits").move_cursor_down() end,  desc = "Go Down Window" },
        { keys.move_up,      function() require("smart-splits").move_cursor_up() end,    desc = "Go Up Window" },
        { keys.move_right,   function() require("smart-splits").move_cursor_right() end, desc = "Go Right Window" },
        -- Window Resize
        { keys.resize_left,  function() require("smart-splits").resize_left() end,       desc = "Window Width -10" },
        { keys.resize_right, function() require("smart-splits").resize_right() end,      desc = "Window Width +10" },
        { keys.resize_down,  function() require("smart-splits").resize_down() end,       desc = "Window Height +10" },
        { keys.resize_up,    function() require("smart-splits").resize_up() end,         desc = "Window Height -10" },
      }
    end,
    config = function()
      require("plugin-config.smart-splits").setup()
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
    init = function()
      -- Disable markview's nvim-cmp integration to avoid conflicts with blink.compat's fake cmp module
      -- (blink.compat sets package.loaded["cmp"].setup to boolean, causing
      --  markview to error when calling cmp.setup.filetype())
      vim.g.markview_cmp_loaded = true
    end,
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
  -- ╭────────────────────────────────────────────────────────╮
  -- │ wrapped - Neovim Usage Statistics (fun plugin)         │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "aikhe/wrapped.nvim",
    dependencies = { "nvzone/volt" },
    cmd = { "WrappedNvim" },
    opts = {},
  },
}
