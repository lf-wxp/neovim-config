-- ╭────────────────────────────────────────────────────────╮
-- │              Language Specific Extensions              │
-- ╰────────────────────────────────────────────────────────╯

local toggle = require("config.plugin-toggle")

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ Rust Enhancement                                       │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "mrcjkb/rustaceanvim",
    enabled = toggle.is_enabled("rustaceanvim"),
    ft = "rust",
  },

  {
    "saecki/crates.nvim",
    enabled = toggle.is_enabled("crates.nvim"),
    event = "BufRead Cargo.toml",
    dependencies = "nvim-lua/plenary.nvim",
    keys = function()
      local keys = require("config.keymaps").crates
      return {
        { keys.toggle, function() require("crates").toggle() end, ft = "toml", desc = "Crate Toggle" },
        { keys.reload, function() require("crates").reload() end, ft = "toml", desc = "Crate Reload" },
        { keys.versions, function() require("crates").show_versions_popup() end, ft = "toml", desc = "Crate Versions" },
        { keys.features, function() require("crates").show_features_popup() end, ft = "toml", desc = "Crate Features" },
        { keys.dependencies, function() require("crates").show_dependencies_popup() end, ft = "toml", desc = "Crate Dependencies" },
        { keys.update, function() require("crates").update_crate() end, ft = "toml", desc = "Crate Update" },
        { keys.upgrade, function() require("crates").upgrade_crate() end, ft = "toml", desc = "Crate Upgrade" },
        { keys.upgrade_all, function() require("crates").upgrade_all_crates() end, ft = "toml", desc = "Crate Upgrade All" },
        { keys.open_homepage, function() require("crates").open_crate_homepage() end, ft = "toml", desc = "Crate Homepage" },
        { keys.open_repo, function() require("crates").open_repository() end, ft = "toml", desc = "Crate Repository" },
        { keys.open_doc, function() require("crates").open_documentation() end, ft = "toml", desc = "Crate Documentation" },
        { keys.open_crates_io, function() require("crates").open_crates_io() end, ft = "toml", desc = "Crate crates.io" },
      }
    end,
    opts = {},
  },

  {
    "alexpasmantier/krust.nvim",
    enabled = toggle.is_enabled("krust"),
    ft = "rust",
    opts = {
      keymap = "<leader><leader>r",
      float_win = {
        auto_focus = false,
      },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ Tailwind CSS Enhancement                               │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "luckasRanarison/tailwind-tools.nvim",
    enabled = toggle.is_enabled("tailwind-tools"),
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
    enabled = toggle.is_enabled("codecompanion"),
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionToggle", "CodeCompanionActions" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("plugin-config.codecompanion").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ CodeBuddy - Internal AI Plugin                         │
  -- ╰────────────────────────────────────────────────────────╯
  {
    name = "CodeBuddy",
    enabled = toggle.is_enabled("CodeBuddy"),
    url = "git@git.woa.com:felikszhou/gongfeng-operation-platform.git",
    event = "InsertEnter",  -- Load on InsertEnter for Copilot completion
    cmd = "CodeBuddy",
    init = function()
      -- Disable default tab mapping and let us handle accept key
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      -- Copilot accept is handled by blink.cmp's Super Tab in blink-cmp/setup.lua
    end,
  },
}
