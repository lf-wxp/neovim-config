-- ╭────────────────────────────────────────────────────────╮
-- │       json-language-server - JSON LSP Config           │
-- ╰────────────────────────────────────────────────────────╯

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local opts = {
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}

return opts
