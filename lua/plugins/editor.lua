-- ╭────────────────────────────────────────────────────────╮
-- │                 Editor Enhancement                     │
-- ╰────────────────────────────────────────────────────────╯

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ flash.nvim - Quick Jump                                │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = function()
      local keys = require("config.keymaps").flash
      return {
        { keys.jump, function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash Jump" },
        { keys.treesitter, function() require("flash").treesitter_search() end, mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
      }
    end,
    config = function()
      require("plugin-config.flash").setup()
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
      require("plugin-config.nvim-autopairs").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ multicursor - Multi Cursor Edit                        │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "jake-stewart/multicursor.nvim",
    event = "VeryLazy",
    config = function()
      require("plugin-config.multicursor").setup()
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
  -- │ todo-comments.nvim-TODO Comment Highlight & Navigation │
  -- ╰────────────────────────────────────────────────────────╯  
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
      local keys = require("config.keymaps").todoComments
      return {
        { keys.next, function() require("todo-comments").jump_next() end, desc = "Next TODO Comment" },
        { keys.prev, function() require("todo-comments").jump_prev() end, desc = "Prev TODO Comment" },
        { keys.search, "<cmd>TodoTelescope<cr>", desc = "Search TODO Comments" },
        { keys.search_fixme, "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Search TODO/FIXME" },
      }
    end,
    opts = {
      signs = true,
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
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
    keys = function()
      local keys = require("config.keymaps").treesj
      return {
        { keys.toggle, function() require("treesj").toggle() end, desc = "Toggle Split/Join" },
      }
    end,
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
      require("plugin-config.origami").setup()
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
    keys = function()
      local keys = require("config.keymaps").sniprun
      return {
        { keys.run, function() require("sniprun").run("n") end, desc = "Run Snippet" },
      }
    end,
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
      hl_priority = 1000,
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
    keys = function()
      local keys = require("config.keymaps").yanky
      return {
        -- Paste from clipboard ring
        { keys.paste_after,  "<Plug>(YankyPutAfter)",              mode = { "n", "x" }, desc = "Paste After" },
        { keys.paste_before,  "<Plug>(YankyPutBefore)",             mode = { "n", "x" }, desc = "Paste Before" },
        { keys.g_paste_after, "<Plug>(YankyGPutAfter)",             mode = { "n", "x" }, desc = "G-Paste After" },
        { keys.g_paste_before, "<Plug>(YankyGPutBefore)",            mode = { "n", "x" }, desc = "G-Paste Before" },
        -- Navigate clipboard history
        { keys.cycle_next, "<Plug>(YankyCycleForward)",       mode = "n",         desc = "Next Clipboard Entry" },
        { keys.cycle_prev, "<Plug>(YankyCycleBackward)",      mode = "n",         desc = "Prev Clipboard Entry" },
        -- Open yank history picker with Telescope
        { keys.yank_history, function() require("telescope").extensions.yank_history.yank_history() end, mode = { "n", "x" }, desc = "Yank History" },
      }
    end,
    config = function()
      require("plugin-config.yanky").setup()
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
