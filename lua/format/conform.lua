local status, conform = pcall(require, "conform")
if not status then
  vim.notify("没有找到 conform")
  return
end

conform.setup({
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    javascript = { "prettierd", "prettier", "oxfmt", stop_after_first = true },
    typescript = { "prettierd", "prettier", "oxfmt", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", "oxfmt", stop_after_first = true },
    vue = { "prettierd", "prettier", "oxfmt", stop_after_first = true },
    css = { "prettierd", "prettier", "oxfmt", stop_after_first = true },
    scss = { "prettierd", "prettier", "oxfmt", stop_after_first = true },
    json = { "prettierd", "prettier", "oxfmt", stop_after_first = true },
  },
})
