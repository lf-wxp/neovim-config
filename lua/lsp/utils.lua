-- ╭────────────────────────────────────────────────────────╮
-- │                  LSP Utility Functions                 │
-- │                                                        │
-- │ Purpose: Shared utilities for LSP configuration        │
-- │ Features:                                              │
-- │   - Default LSP capabilities (blink.cmp + folding)    │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

--- Build default LSP capabilities with folding support
--- Note: blink.cmp capabilities are merged lazily on LspAttach
--- to avoid loading blink.cmp during startup (~50ms savings)
---@return lsp.ClientCapabilities
M.get_default_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Support LSP folding ranges (used by origami.nvim)
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end

--- Merge blink.cmp capabilities into an existing client (called lazily on LspAttach)
--- This avoids loading blink.cmp at startup, deferring it to InsertEnter
---@param client vim.lsp.Client
M.merge_blink_capabilities = function(client)
  local ok, blink = pcall(require, "blink.cmp")
  if ok then
    local enhanced = blink.get_lsp_capabilities(client.capabilities)
    client.capabilities = enhanced
  end
end

return M
