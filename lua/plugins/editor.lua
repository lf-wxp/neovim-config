-- ╭────────────────────────────────────────────────────────╮
-- │                 Editor Enhancement                     │
-- ╰────────────────────────────────────────────────────────╯

local toggle = require("config.plugin-toggle")

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ flash.nvim - Quick Jump                                │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "folke/flash.nvim",
    enabled = toggle.is_enabled("flash.nvim"),
    event = "VeryLazy",
    keys = function()
      local keys = require("config.keymaps").flash
      return {
        { keys.jump,       function() require("flash").jump() end,              mode = { "n", "x", "o" }, desc = "Flash Jump" },
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
    enabled = toggle.is_enabled("nvim-surround"),
    event = "VeryLazy",
    dependencies = { "roobert/surround-ui.nvim" },
    config = function()
      require("nvim-surround").setup({})
      -- Load surround-ui after nvim-surround is ready
      require("surround-ui").setup({ root_key = "S" })
    end,
  },

  -- surround-ui.nvim: loaded via nvim-surround's dependencies, no standalone spec needed

  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-autopairs - Auto Pairs                            │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "windwp/nvim-autopairs",
    enabled = toggle.is_enabled("nvim-autopairs"),
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
    enabled = toggle.is_enabled("multicursor"),
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
    enabled = toggle.is_enabled("ts-comments"),
    event = "VeryLazy",
    opts = {},
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ Comment.nvim - Smart Commenting                        │
  -- │ Enhanced comment toggling with line/block support      │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "numToStr/Comment.nvim",
    enabled = toggle.is_enabled("Comment.nvim"),
    event = "VeryLazy",
    keys = function()
      local keys = require("config.keymaps").comment
      return {
        { keys.toggler.line,        nil, mode = { "n" },          desc = "Comment Toggle Line" },
        { keys.toggler.block,       nil, mode = { "n" },          desc = "Comment Toggle Block" },
        { keys.opleader.line,       nil, mode = { "n", "x" },     desc = "Comment Line" },
        { keys.opleader.block,      nil, mode = { "n", "x" },     desc = "Comment Block" },
        { keys.extra.below,         nil, mode = { "n" },          desc = "Comment Below" },
        { keys.extra.above,         nil, mode = { "n" },          desc = "Comment Above" },
        { keys.extra.eol,           nil, mode = { "n" },          desc = "Comment End of Line" },
      }
    end,
    config = function()
      require("plugin-config.comment").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ dial.nvim - Enhanced Increment/Decrement               │
  -- │ Smart value cycling for dates, booleans, semver, etc.  │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "monaqa/dial.nvim",
    enabled = toggle.is_enabled("dial.nvim"),
    keys = function()
      local keys = require("config.keymaps").dial
      return {
        { keys.increment,         function() require("dial.map").manipulate("increment", "normal") end,  mode = "n", desc = "Dial Increment" },
        { keys.decrement,         function() require("dial.map").manipulate("decrement", "normal") end,  mode = "n", desc = "Dial Decrement" },
        { keys.increment_global,  function() require("dial.map").manipulate("increment", "gnormal") end, mode = "n", desc = "Dial Increment (global)" },
        { keys.decrement_global,  function() require("dial.map").manipulate("decrement", "gnormal") end, mode = "n", desc = "Dial Decrement (global)" },
        { keys.increment_visual,  function() require("dial.map").manipulate("increment", "visual") end,  mode = "x", desc = "Dial Increment" },
        { keys.decrement_visual,  function() require("dial.map").manipulate("decrement", "visual") end,  mode = "x", desc = "Dial Decrement" },
        { keys.increment_gvisual, function() require("dial.map").manipulate("increment", "gvisual") end, mode = "x", desc = "Dial Increment (global)" },
        { keys.decrement_gvisual, function() require("dial.map").manipulate("decrement", "gvisual") end, mode = "x", desc = "Dial Decrement (global)" },
      }
    end,
    config = function()
      require("plugin-config.dial").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ todo-comments.nvim-TODO Comment Highlight & Navigation │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "folke/todo-comments.nvim",
    enabled = toggle.is_enabled("todo-comments"),
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
      local keys = require("config.keymaps").todoComments
      return {
        { keys.next,         function() require("todo-comments").jump_next() end, desc = "Next TODO Comment" },
        { keys.prev,         function() require("todo-comments").jump_prev() end, desc = "Prev TODO Comment" },
        { keys.search,       "<cmd>TodoTelescope<cr>",                            desc = "Search TODO Comments" },
        { keys.search_fixme, "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Search TODO/FIXME" },
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
    enabled = toggle.is_enabled("mini.ai"),
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ treesj - Split/Join Code Blocks                        │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "Wansmer/treesj",
    enabled = toggle.is_enabled("treesj"),
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
    enabled = toggle.is_enabled("nvim-origami"),
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
    enabled = toggle.is_enabled("nvim-recorder"),
    event = "VeryLazy",
    opts = {},
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ coerce - Case Conversion                               │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "gregorias/coerce.nvim",
    enabled = toggle.is_enabled("coerce"),
    event = "VeryLazy",
    opts = {},
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ marks - Marks Enhancement                              │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "chentoast/marks.nvim",
    enabled = toggle.is_enabled("marks.nvim"),
    event = "BufReadPost",
    opts = {
      builtin_marks = { ".", "<", ">", "^" },
      excluded_filetypes = { "sagahover", "sagacodeaction", "sagafinder", "sagarename" },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ atone - Undo Enhancement                               │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "XXiaoA/atone.nvim",
    enabled = toggle.is_enabled("atone"),
    cmd = "Atone",
    opts = {},
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ sniprun - Run Code Snippet                             │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "michaelb/sniprun",
    enabled = toggle.is_enabled("sniprun"),
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

  -- nvim-context_vt removed: default disabled + treesitter-context already provides
  -- code block context at the top. This plugin was never actively used.

  -- hlargs.nvim removed: LSP semantic tokens (@lsp.type.parameter) already
  -- provides argument highlighting with better coverage and zero overhead.

  -- ╭────────────────────────────────────────────────────────╮
  -- │ yanky.nvim - Clipboard Ring History                    │
  -- │ Enhanced yank/paste with history navigation            │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "gbprod/yanky.nvim",
    enabled = toggle.is_enabled("yanky.nvim"),
    dependencies = { "kkharji/sqlite.lua", "nvim-telescope/telescope.nvim" },
    keys = function()
      local keys = require("config.keymaps").yanky
      return {
        -- Paste via yanky with auto-indent (== filter after paste)
        { keys.paste_after,    "<Plug>(YankyPutAfterFilter)",    mode = { "n", "x" }, desc = "Paste After (auto-indent)" },
        { keys.paste_before,   "<Plug>(YankyPutBeforeFilter)",   mode = { "n", "x" }, desc = "Paste Before (auto-indent)" },
        { keys.g_paste_after,  "<Plug>(YankyGPutAfterFilter)",   mode = { "n", "x" }, desc = "G-Paste After (auto-indent)" },
        { keys.g_paste_before, "<Plug>(YankyGPutBeforeFilter)",  mode = { "n", "x" }, desc = "G-Paste Before (auto-indent)" },
        -- Navigate clipboard history (only works after a yanky paste)
        { keys.cycle_next,     "<Plug>(YankyCycleForward)",                                                mode = "n",          desc = "Next Clipboard Entry" },
        { keys.cycle_prev,     "<Plug>(YankyCycleBackward)",                                               mode = "n",          desc = "Prev Clipboard Entry" },
        -- Open yank history picker with Telescope
        { keys.yank_history,   function() require("telescope").extensions.yank_history.yank_history() end, mode = { "n", "x" }, desc = "Yank History" },
      }
    end,
    config = function()
      require("plugin-config.yanky").setup()
    end,
  },

  -- highlight-undo.nvim removed: tiny-glimmer.nvim already provides
  -- undo/redo visual feedback (see ui.lua → tiny-glimmer overwrite.undo/redo)

  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-ts-autotag - Auto Close/Rename HTML Tags          │
  -- │ Automatically rename paired HTML/XML tags              │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "windwp/nvim-ts-autotag",
    enabled = toggle.is_enabled("nvim-ts-autotag"),
    ft = { "html", "xml", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "astro" },
    opts = {
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
    },
  },
  -- smart-paste.nvim no longer needed:
  -- yanky.nvim's <Plug>(Yanky*Filter) mappings auto-execute == (auto-indent) after paste,
  -- equivalent to smart-paste's intelligent indentation, fully compatible with yanky's cycle history.
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ smart-backspace.nvim - Intelligent Backspace Behavior    │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "qwavies/smart-backspace.nvim",
    enabled = toggle.is_enabled("smart-backspace"),
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {},
  },
}
