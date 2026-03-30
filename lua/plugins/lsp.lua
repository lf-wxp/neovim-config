-- ╭────────────────────────────────────────────────────────╮
-- │                    LSP Related                         │
-- ╰────────────────────────────────────────────────────────╯

local toggle = require("config.plugin-toggle")

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-lspconfig - LSP Core                              │
  -- │ Entry point: loads lsp/setup.lua which handles all     │
  -- │ server configuration, keymaps, and UI                  │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "neovim/nvim-lspconfig",
    enabled = toggle.is_enabled("nvim-lspconfig"),
    cmd = "LspInfo",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("lsp.setup").setup()
    end,
  },
  -- ╭────────────────────────────────────────────────────────╮
  -- │ mason.nvim - LSP/DAP/Linter Manager                    │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "williamboman/mason.nvim",
    enabled = toggle.is_enabled("mason.nvim"),
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed = "󰄬",
          package_pending = "󰐔",
          package_uninstalled = "󰚌",
        },
      },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ mason-lspconfig - Mason & LSPConfig Bridge             │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "williamboman/mason-lspconfig.nvim",
    enabled = toggle.is_enabled("mason-lspconfig"),
    opts = {
      ensure_installed = {
        "cssls",
        "html",
        "jsonls",
        "rust_analyzer",
        "taplo",
        "vue_ls",
        "lua_ls",
        "vtsls",
        "zk",
        "oxlint",
        "tailwindcss",
        "typos_lsp",
      },
      -- Disable automatic_enable since setup.lua manually manages vim.lsp.enable()
      automatic_enable = false,
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ mason-tool-installer - Auto Install Formatters/Linters │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    enabled = toggle.is_enabled("mason-tool-installer"),
    dependencies = { "williamboman/mason.nvim" },
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        -- Formatters
        "oxfmt",
        { "prettierd", auto_update = true }, -- Auto-update prettierd to keep prettier peer dep in sync
        "stylua",
        "isort",
        "black",
      },
      auto_update = false,
      run_on_start = true,
      integrations = {
        ["mason-lspconfig"] = false, -- LSP servers managed separately by mason-lspconfig
      },
    },
    config = function(_, opts)
      require("mason-tool-installer").setup(opts)

      -- Ensure prettierd has prettier peer dependency after installation
      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsUpdateCompleted",
        once = true, -- Only need to check once per session
        callback = function()
          local prettierd_dir = vim.fn.stdpath("data") .. "/mason/packages/prettierd"
          local prettier_dir = prettierd_dir .. "/node_modules/prettier"
          if vim.fn.isdirectory(prettierd_dir) == 1 and vim.fn.isdirectory(prettier_dir) == 0 then
            vim.fn.jobstart({ "npm", "install", "prettier" }, {
              cwd = prettierd_dir,
              on_exit = function(_, code)
                local msg = code == 0 and "prettier installed for prettierd"
                  or "Failed to install prettier for prettierd"
                local level = code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
                vim.schedule(function()
                  vim.notify(msg, level)
                end)
              end,
            })
          end
        end,
      })
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ lspsaga - LSP UI Enhancement                           │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "nvimdev/lspsaga.nvim",
    enabled = toggle.is_enabled("lspsaga"),
    -- Load on LspAttach event to ensure lspsaga is ready before common.lua's LspAttach callback runs.
    -- Buffer-local mappings in common.lua take priority over lazy keys' global mappings;
    -- using keys-based lazy-loading would cause buffer-local mappings to bypass the lazy trigger, resulting in E492
    event = "LspAttach",
    keys = function()
      local saga = require("config.keymaps").lspsaga
      return {
        -- Only keep lspsaga-specific peek/action keybindings (no duplicates with common.lua)
        { saga.peek_definition, "<cmd>Lspsaga peek_definition<cr>", desc = "Peek Definition" },
        { saga.peek_implementation, "<cmd>Lspsaga finder imp<cr>", desc = "Peek Implementation" },
        { saga.peek_references, "<cmd>Lspsaga finder ref<cr>", desc = "Peek References" },
        { saga.peek_type, "<cmd>Lspsaga peek_type_definition<cr>", desc = "Peek Type Definition" },
        { saga.code_action, "<cmd>Lspsaga code_action<cr>", mode = { "n", "v" }, desc = "Code Action" },
        { saga.rename, "<cmd>Lspsaga rename<cr>", desc = "Rename" },
      }
    end,
    config = function()
      require("plugin-config.lspsaga").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ symbol-usage - Symbol Reference Count                  │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "Wansmer/symbol-usage.nvim",
    enabled = toggle.is_enabled("symbol-usage"),
    event = "LspAttach",
    config = function()
      require("plugin-config.symbol-usage").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ lazydev - Lua Development Enhancement                  │
  -- │ Provides Neovim Lua API completion and type info       │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "folke/lazydev.nvim",
    enabled = toggle.is_enabled("lazydev"),
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        -- Common plugin libraries for type completion
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "lazy.nvim", words = { "LazyPluginSpec" } },
        { path = "plenary.nvim" },
      },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ schemastore - JSON Schema Support                      │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "b0o/schemastore.nvim",
    enabled = toggle.is_enabled("schemastore"),
    ft = { "json", "jsonc", "yaml" },
  },
}
