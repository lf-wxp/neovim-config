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
    config = function()
      require("plugin-config.nvim-surround")
    end,
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
  -- │ origami - Fold Enhancement                             │
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
    config = function()
      require("plugin-config.marks")
    end,
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
    config = function()
      require("plugin-config.sniprun")
    end,
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
}
