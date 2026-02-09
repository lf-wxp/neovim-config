-- ╭────────────────────────────────────────────────────────╮
-- │                  Formatting and Lint                   │
-- ╰────────────────────────────────────────────────────────╯

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
      format_on_save = function(bufnr)
        -- Skip formatting for large files (> 200KB)
        local buf_name = vim.api.nvim_buf_get_name(bufnr)
        local file_size = vim.fn.getfsize(buf_name)
        if file_size > 200 * 1024 then
          return
        end
        -- Skip formatting for certain filetypes
        local ignore_filetypes = { "sql", "java" }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end,
      formatters_by_ft = {
        -- lua: use stylua, install: cargo install stylua
        lua = { "stylua", stop_after_first = true },
        -- python: isort (sort imports) + black (format), run sequentially
        python = { "isort", "black" },
        -- rust: rustfmt
        rust = { "rustfmt", lsp_format = "fallback" },
        -- JS/TS: prefer oxfmt, fallback prettierd/prettier
        javascript = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
        typescript = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
        vue = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
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
  -- │ nvim-lint - Async Linting                              │
  -- │ Note: oxlint runs as LSP server, no need here          │
  -- │ Add non-LSP linters here (e.g. markdownlint,shellcheck)│
  -- ╰────────────────────────────────────────────────────────╯
  {
    "mfussenegger/nvim-lint",
    enabled = false, -- Disabled: linters_by_ft is empty, no actual linter config; enable and add linters when needed
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        -- oxlint diagnostics are provided by oxlint LSP server
        -- Add non-LSP linters below:
        -- markdown = { "markdownlint" },
        -- sh = { "shellcheck" },
      }

      -- Auto-lint on save, read and leaving insert mode
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
          -- Only lint if buffer is modifiable (skip readonly/special buffers)
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
