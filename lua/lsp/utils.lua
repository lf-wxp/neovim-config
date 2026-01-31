local M = {}

M.get_default_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- 支持 LSP 提供的折叠范围（origami.nvim 会利用此信息）
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end

return M
