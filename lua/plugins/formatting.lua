-- ╭──────────────────────────────────────────────────────────╮
-- │                    Formatting and Lint                    │
-- ╰──────────────────────────────────────────────────────────╯

return {
-- ╭────────────────────────────────────────────────────────╮
-- │ conform.nvim - Formatter                               │
-- ╰────────────────────────────────────────────────────────╯
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = function()
      local keys = require("config.keymaps").conform
      return {
        {
          keys.format,
          function()
            require("conform").format({ async = true, lsp_format = "fallback" })
          end,
          desc = "Format",
        },
      }
    end,
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        -- lua: use stylua, install: cargo install stylua
        lua = { "stylua", stop_after_first = true },
        -- python: isort and black
        python = { "isort", "black", stop_after_first = true },
        -- rust: rustfmt
        rust = { "rustfmt", lsp_format = "fallback" },
        -- JS/TS: prefer prettierd, fallback prettier
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ none-ls (null-ls) - Diagnostics and Code Actions       │
  -- │ Kept for: eslint diagnostics/actions and cspell        │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "nvimtools/none-ls.nvim",
    cmd = "NullLsInfo", -- Only load when NullLsInfo is called
    event = "LspAttach", -- Load when LSP attaches
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls-extras.nvim",
      "davidmh/cspell.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        debug = false,
        sources = {
          -- ESLint diagnostics and code actions
          require("none-ls.diagnostics.eslint"),
          require("none-ls.code_actions.eslint"),
          -- cspell spell checking
          require("cspell.diagnostics"),
          require("cspell.code_actions"),
        },
        diagnostics_format = "[#{s}] #{m}",
        on_attach = function(_)
          vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()']])
        end,
      })
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ mason-null-ls - Mason & null-ls Bridge                 │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "jay-babu/mason-null-ls.nvim",
    cmd = "NullLsInstall", -- Load when installing null-ls sources
    event = "LspAttach", -- Also load when LSP attaches
    dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },    opts = {
      ensure_installed = { "eslint_d", "prettierd", "stylua" },
      automatic_installation = true,
    },
  },
}
