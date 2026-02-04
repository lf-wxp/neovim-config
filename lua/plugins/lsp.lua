-- ╭──────────────────────────────────────────────────────────╮
-- │                      LSP Related                          │
-- ╰──────────────────────────────────────────────────────────╯

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ nvim-lspconfig - LSP Core                              │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("lsp.setup")
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
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
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
      },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ lspsaga - LSP UI Enhancement                           │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    keys = {
      { "gpd", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek Definition" },
      { "gpi", "<cmd>Lspsaga finder imp<cr>", desc = "Peek Implementation" },
      { "gpc", "<cmd>Lspsaga term_toggle<cr>", desc = "Close Preview" },
      { "gpr", "<cmd>Lspsaga finder ref<cr>", desc = "Peek References" },
      { "gpt", "<cmd>Lspsaga peek_type_definition<cr>", desc = "Peek Type Definition" },
      { "<leader>ca", "<cmd>Lspsaga code_action<cr>", mode = { "n", "v" }, desc = "Code Action" },
      { "<leader>rn", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
    },
    config = function()
      require("cmp.lspsaga")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ symbol-usage - Symbol Reference Count                  │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    config = function()
      require("plugin-config.symbol-usage")
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
