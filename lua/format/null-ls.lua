local status, null_ls = pcall(require, "null-ls")
if not status then
  vim.notify("没有找到 null-ls")
  return
end

null_ls.setup({
  debug = false,
  sources = {
    -- require("typescript.extensions.null-ls.code-actions"),
    require("none-ls.diagnostics.eslint"),
    -- require("none-ls.diagnostics.yamllint"), -- 需要安装: pip install yamllint
    require("none-ls.code_actions.eslint"),
    -- require("none-ls.formatting.eslint_d"),
    -- require("none-ls.formatting.rustfmt"),
    -- require("none-ls.formatting.beautysh"),
    require("cspell.diagnostics"),
    require("cspell.code_actions")
  },
  -- #{m}: message
  -- #{s}: source name (defaults to null-ls if not specified)
  -- #{c}: code (if available)
  diagnostics_format = "[#{s}] #{m}",
  on_attach = function(_)
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()']])
  end,
})
