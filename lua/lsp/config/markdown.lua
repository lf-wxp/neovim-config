local common = require("lsp.common-config")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, bufnr)
    common.keyAttach(bufnr)
    common.navic(client, bufnr)
  end,
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
