-- ╭────────────────────────────────────────────────────────╮
-- │                    Git Related                         │
-- ╰────────────────────────────────────────────────────────╯

local toggle = require("config.plugin-toggle")

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ gitsigns - Git Signs                                   │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "lewis6991/gitsigns.nvim",
    enabled = toggle.is_enabled("gitsigns"),
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("plugin-config.gitsigns").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ neogit - Git Interface                                 │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "NeogitOrg/neogit",
    enabled = toggle.is_enabled("neogit"),
    cmd = "Neogit",
    keys = function()
      local keys = require("config.keymaps").neogit
      return {
        { keys.open, "<cmd>Neogit<cr>", desc = "Open Neogit" },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      graph_style = "unicode",
      process_spinner = true,
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ diffview - Diff View                                   │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "sindrets/diffview.nvim",
    enabled = toggle.is_enabled("diffview"),
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugin-config.diffview").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ git-conflict - Git Conflict Resolution                 │
  -- │ Lazy load only during git merge/rebase conflicts       │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "akinsho/git-conflict.nvim",
    enabled = toggle.is_enabled("git-conflict"),
    version = "*",
    cmd = {
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
      "GitConflictListQf",
      "GitConflictRefresh",
    },
    init = function()
      require("plugin-config.git-conflict").init()
    end,
    config = function()
      require("plugin-config.git-conflict").setup()
    end,
  },
}
