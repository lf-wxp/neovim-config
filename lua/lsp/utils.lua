-- ╭────────────────────────────────────────────────────────╮
-- │                  LSP Utility Functions                 │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.get_default_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Merge blink.cmp LSP capabilities
  local ok, blink = pcall(require, "blink.cmp")
  if ok then
    capabilities = blink.get_lsp_capabilities(capabilities)
  end

  -- Support LSP folding ranges (origami.nvim will use this info)
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end

return M
