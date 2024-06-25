local common = require("lsp.common-config")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
  init_options = {
    vue = {
      hybridMode = false,
    },
    -- typescript = {
    --   tsdk = vim.fn.getcwd() .. "node_modules/typescript",
    -- },
  },
  on_attach = function(client, bufnr)
    common.navic(client, bufnr)
    common.disableFormat(client)
    common.keyAttach(bufnr)
  end,
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
