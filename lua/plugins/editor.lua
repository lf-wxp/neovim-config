-- ╭──────────────────────────────────────────────────────────╮
-- │                      Editor Enhancement                   │
-- ╰──────────────────────────────────────────────────────────╯

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ flash.nvim - Quick Jump                                │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>f", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash Jump" },
      { "<leader>F", function() require("flash").treesitter_search() end, mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
    },
    config = function()
      require("plugin-config.flash")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-surround - Surround Edit                          │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
      keymaps = {
        normal = "ys",
        normal_line = "yS",
        normal_cur = "yss",
        normal_cur_line = "ySS",
        delete = "ds",
        change = "cs",
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        visual = "s",
        visual_line = "gs",
      },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ surround-ui - Surround Visualization                   │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "roobert/surround-ui.nvim",
    event = "VeryLazy",
    dependencies = "kylechui/nvim-surround",
    opts = { root_key = "S" },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-autopairs - Auto Pairs                            │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugin-config.nvim-autopairs")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ multicursor - Multi Cursor Edit                        │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "jake-stewart/multicursor.nvim",
    branch = "main",
    event = "VeryLazy",
    config = function()
      require("plugin-config.multicursor")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ ts-comments - Better Comment Support                   │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ mini.ai - Enhanced Text Objects                        │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "echasnovski/mini.ai",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ treesj - Split/Join Code Blocks                        │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>e", function() require("treesj").toggle() end, desc = "Toggle Split/Join" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { use_default_keymaps = false },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-origami - Smart Code Folding                      │
  -- │ Remember and restore fold states automatically         │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "chrisgrieser/nvim-origami",
    event = "BufReadPost",
    config = function()
      require("plugin-config.origami")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-recorder - Macro Recording Enhancement            │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "chrisgrieser/nvim-recorder",
    event = "VeryLazy",
    opts = {},
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ coerce - Case Conversion                               │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "gregorias/coerce.nvim",
    event = "VeryLazy",
    config = true,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ marks - Marks Enhancement                              │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "chentoast/marks.nvim",
    event = "BufReadPost",
    opts = {
      builtin_marks = { ".", "<", ">", "^" },
      excluded_filetypes = { "LspsagaHover", "LspsagaCodeAction", "LspsagaHoverDoc" },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ atone - Undo Enhancement                               │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "XXiaoA/atone.nvim",
    cmd = "Atone",
    opts = {},
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ sniprun - Run Code Snippet                             │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "michaelb/sniprun",
    build = "sh ./install.sh",
    keys = {
      { "<leader>R", function() require("sniprun").run("n") end, desc = "Run Snippet" },
    },
    opts = {
      selected_interpreters = { "JS_TS_deno" },
      repl_enable = { "JS_TS_deno" },
      display = { "Terminal" },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-context_vt - Context Virtual Text                 │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "andersevenrud/nvim_context_vt",
    event = "BufReadPost",
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ hlargs - Argument Highlight                            │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "m-demare/hlargs.nvim",
    event = "BufReadPost",
    opts = {
      color = Hlargs,
      hl_priority = 1000,
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ ssr.nvim - Structural Search and Replace               │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "cshuaimin/ssr.nvim",
    keys = {
      { "<leader>ssr", function() require("ssr").open() end, mode = { "n", "x" }, desc = "Structural Search Replace" },
    },
    opts = {
      min_width = 50,
      min_height = 5,
      keymaps = {
        close = "q",
        next_match = "n",
        prev_match = "N",
        replace_confirm = "<cr>",
        replace_all = "<leader><cr>",
      },
    },
  },
  -- ╭────────────────────────────────────────────────────────╮
  -- │ yanky.nvim - Clipboard Ring History                    │
  -- │ Enhanced yank/paste with history navigation            │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "gbprod/yanky.nvim",
    dependencies = { "kkharji/sqlite.lua", "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    keys = {
      -- Paste from clipboard ring
      { "p",  "<Plug>(YankyPutAfter)",              mode = { "n", "x" }, desc = "Paste After" },
      { "P",  "<Plug>(YankyPutBefore)",             mode = { "n", "x" }, desc = "Paste Before" },
      { "gp", "<Plug>(YankyGPutAfter)",             mode = { "n", "x" }, desc = "G-Paste After" },
      { "gP", "<Plug>(YankyGPutBefore)",            mode = { "n", "x" }, desc = "G-Paste Before" },
      -- Navigate clipboard history
      { "<c-n>", "<Plug>(YankyCycleForward)",       mode = "n",         desc = "Next Clipboard Entry" },
      { "<c-p>", "<Plug>(YankyCycleBackward)",      mode = "n",         desc = "Prev Clipboard Entry" },
      -- Open yank history picker with Telescope
      { "<leader>P", function() require("telescope").extensions.yank_history.yank_history() end, mode = { "n", "x" }, desc = "Yank History" },
    },
    config = function()
      require("yanky").setup(require("plugin-config.yanky").opts)
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ highlight-undo.nvim - Visual Undo/Redo Feedback        │
  -- │ Highlights the text that was changed by undo/redo      │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "tzachar/highlight-undo.nvim",
    event = "VeryLazy",
    opts = {
      duration = 300,
      undo = { hlgroup = "HighlightUndo", mode = "n", lhs = "u", map = "undo", opts = {} },
      redo = { hlgroup = "HighlightRedo", mode = "n", lhs = "<C-r>", map = "redo", opts = {} },
      highlight_for_count = true,
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-ts-autotag - Auto Close/Rename HTML Tags          │
  -- │ Automatically rename paired HTML/XML tags              │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
        per_filetype = {
          ["html"] = {
            enable_close = true,
          },
        },
      })
    end,
  },
}
