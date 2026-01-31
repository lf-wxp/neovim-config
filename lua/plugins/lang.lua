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
    keys = {
      { "<leader>ct", function() require("crates").toggle() end, desc = "Crate Toggle" },
      { "<leader>cr", function() require("crates").reload() end, desc = "Crate Reload" },
      { "<leader>cv", function() require("crates").show_versions_popup() end, desc = "Crate Versions" },
      { "<leader>cf", function() require("crates").show_features_popup() end, desc = "Crate Features" },
      { "<leader>cd", function() require("crates").show_dependencies_popup() end, desc = "Crate Dependencies" },
      { "<leader>cu", function() require("crates").update_crate() end, desc = "Crate Update" },
      { "<leader>cU", function() require("crates").upgrade_crate() end, desc = "Crate Upgrade" },
      { "<leader>cA", function() require("crates").upgrade_all_crates() end, desc = "Crate Upgrade All" },
      { "<leader>cH", function() require("crates").open_homepage() end, desc = "Crate Homepage" },
      { "<leader>cR", function() require("crates").open_repository() end, desc = "Crate Repository" },
      { "<leader>cD", function() require("crates").open_documentation() end, desc = "Crate Documentation" },
      { "<leader>cC", function() require("crates").open_crates_io() end, desc = "Crate crates.io" },
    },
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
