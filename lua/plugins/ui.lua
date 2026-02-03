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
      { "<leader>h", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Tab" },
      { "<leader>l", "<cmd>BufferLineCycleNext<cr>", desc = "Next Tab" },
      { "<leader><", "<cmd>BufferLineMovePrev<cr>", desc = "Move Tab Left" },
      { "<leader>>", "<cmd>BufferLineMoveNext<cr>", desc = "Move Tab Right" },
      { "<leader>tp", "<cmd>BufferLinePick<cr>", desc = "Pick Tab" },
      { "<leader>tc", "<cmd>Bdelete!<cr>", desc = "Close Tab" },
      { "<leader>bcl", "<cmd>BufferLineCloseRight<cr>", desc = "Close Right Tabs" },
      { "<leader>bch", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Left Tabs" },
      { "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Pick Close Tab" },
    },
    opts = {
      options = {
        close_command = "Bdelete! %d",
        separator_style = "slant",
        numbers = "both",
        right_mouse_command = "Bdelete! %d",
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
        indicator = { style = "underline" },
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and "  " or (e == "warning" and "  " or "  ")
            s = s .. n .. sym
          end
          return s
        end,
      },
    },
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
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        opts = {
          win_options = { winblend = 20 },
          border = { style = "solid", padding = { 0, 0 } },
        },
        format = {
          cmdline = { pattern = "^:", icon = " ", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = " ", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "󰢱 ", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "󰘥 " },
          input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
        },
      },
      messages = {
        enabled = true,
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },
      popupmenu = {
        enabled = true,
        backend = "nui",
        kind_icons = {},
      },
      lsp = {
        progress = {
          enabled = true,
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          throttle = 1000 / 30,
          view = "mini",
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
          ["vim.lsp.util.stylize_markdown"] = false,
          ["cmp.entry.get_documentation"] = false,
        },
        hover = { enabled = true, silent = false },
        signature = { enabled = false },
        message = { enabled = true, view = "notify" },
      },
      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = false,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
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
      { "<leader>;", function() Snacks.dashboard() end, desc = "Dashboard" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
      { "<c-_>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Terminal" },
      { "<c-/>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Terminal" },
    },
    opts = require("plugin-config.snacks").opts,
    config = function(_, opts)
      require("snacks").setup(opts)
      require("plugin-config.snacks").init()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ fidget.nvim - LSP Progress                             │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    config = function()
      require("plugin-config.fidget")
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
