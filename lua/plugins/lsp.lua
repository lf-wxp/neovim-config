-- ╭────────────────────────────────────────────────────────╮
-- │                    LSP Related                         │
-- ╰────────────────────────────────────────────────────────╯

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-lspconfig - LSP Core                              │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "neovim/nvim-lspconfig",
    cmd = "LspInfo",
    event = { "BufReadPost", "BufNewFile" }, -- Load when opening files so LSP servers can attach
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
  -- │ lspsaga - LSP UI Enhancement                           │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    keys = function()
      local keys = require("config.keymaps").lspsaga
      return {
        { keys.peek_definition, "<cmd>Lspsaga peek_definition<cr>", desc = "Peek Definition" },
        { keys.peek_implementation, "<cmd>Lspsaga finder imp<cr>", desc = "Peek Implementation" },
        { keys.peek_close, "<cmd>Lspsaga term_toggle<cr>", desc = "Close Preview" },
        { keys.peek_references, "<cmd>Lspsaga finder ref<cr>", desc = "Peek References" },
        { keys.peek_type, "<cmd>Lspsaga peek_type_definition<cr>", desc = "Peek Type Definition" },
        { keys.code_action, "<cmd>Lspsaga code_action<cr>", mode = { "n", "v" }, desc = "Code Action" },
        { keys.rename, "<cmd>Lspsaga rename<cr>", desc = "Rename" },
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
    event = "LspAttach",
    config = function()
      require("plugin-config.symbol-usage").setup()
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ lazydev - Lua Development Enhancement                  │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        -- Full Neovim runtime API
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        -- Neovim Lua API
        "LazyVim",
        -- Common Neovim plugin libraries
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
    ft = { "json", "jsonc", "yaml" },
  },
}
