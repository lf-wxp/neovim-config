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
    -- lua: 使用 stylua，需要安装: cargo install stylua
    lua = { "stylua", stop_after_first = true },
    -- python: isort 和 black（black 需要安装: pip install black）
    python = { "isort", "black", stop_after_first = true },
    -- rust: rustfmt
    rust = { "rustfmt", lsp_format = "fallback" },
    -- JS/TS: 优先使用 prettierd，其次 prettier
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    vue = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    scss = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
  },
})
