local opts = {}

-- 查看目录等信息
return {
  on_setup = function(server)
    server.setup(opts)
  end,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}
