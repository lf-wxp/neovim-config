-- ╭────────────────────────────────────────────────────────╮
-- │                  LSP Utility Functions                 │
-- │                                                        │
-- │ Purpose: Shared utilities for LSP configuration        │
-- │ Features:                                              │
-- │   - Default LSP capabilities (blink.cmp + folding)    │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

--- Build default LSP capabilities with blink.cmp and folding support
---@return lsp.ClientCapabilities
M.get_default_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Merge blink.cmp LSP capabilities for enhanced completion
  local ok, blink = pcall(require, "blink.cmp")
  if ok then
    capabilities = blink.get_lsp_capabilities(capabilities)
  end

  -- Support LSP folding ranges (used by origami.nvim)
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end

return M
