-- ╭──────────────────────────────────────────────────────────╮
-- │                    Language Specific Extensions           │
-- ╰──────────────────────────────────────────────────────────╯

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ Rust Enhancement                                       │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "mrcjkb/rustaceanvim",
    version = "^3",
    ft = "rust",
  },

  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    dependencies = "nvim-lua/plenary.nvim",
    keys = function()
      local keys = require("config.keymaps").crates
      return {
        { keys.toggle, "<cmd>lua require('config.commands').crate_toggle()<cr>", desc = "Crate Toggle" },
        { keys.reload, "<cmd>lua require('config.commands').crate_reload()<cr>", desc = "Crate Reload" },
        { keys.versions, "<cmd>lua require('config.commands').crate_versions()<cr>", desc = "Crate Versions" },
        { keys.features, "<cmd>lua require('config.commands').crate_features()<cr>", desc = "Crate Features" },
        { keys.dependencies, "<cmd>lua require('config.commands').crate_dependencies()<cr>", desc = "Crate Dependencies" },
        { keys.update, "<cmd>lua require('config.commands').crate_update()<cr>", desc = "Crate Update" },
        { keys.upgrade, "<cmd>lua require('config.commands').crate_upgrade()<cr>", desc = "Crate Upgrade" },
        { keys.upgrade_all, "<cmd>lua require('config.commands').crate_upgrade_all()<cr>", desc = "Crate Upgrade All" },
        { keys.open_homepage, "<cmd>lua require('config.commands').crate_open()<cr>", desc = "Crate Homepage" },
        { keys.open_repo, "<cmd>lua require('config.commands').crate_repo()<cr>", desc = "Crate Repository" },
        { keys.open_doc, "<cmd>lua require('config.commands').crate_doc()<cr>", desc = "Crate Documentation" },
        { keys.open_crates_io, "<cmd>lua require('config.commands').crate_crates_io()<cr>", desc = "Crate crates.io" },
      }
    end,
    opts = {},
  },

  {
    "alexpasmantier/krust.nvim",
    ft = "rust",
    opts = {
      keymap = "<leader><leader>r",
      float_win = {
        border = "none",
        auto_focus = false,
      },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ Tailwind CSS Enhancement                               │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    ft = { "html", "css", "scss", "javascript", "typescript", "typescriptreact", "vue" },
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      server = {
        override = false,
      },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ AI Assistant                                           │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionToggle", "CodeCompanionActions" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("plugin-config.codecompanion")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ CodeBuddy - Internal AI Plugin                         │
  -- ╰────────────────────────────────────────────────────────╯
  {
    name = "CodeBuddy",
    url = "git@git.woa.com:felikszhou/gongfeng-operation-platform.git",
    lazy = true,
    event = "InsertEnter",
    cmd = "CodeBuddy",
    init = function()
      -- Copilot keymap
      vim.api.nvim_set_keymap("i", "<Right>", "copilot#Accept()", { silent = true, noremap = true, expr = true })
    end,
  },
}
