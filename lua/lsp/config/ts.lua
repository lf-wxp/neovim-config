local common = require("lsp.common-config")
local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
local volar_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = volar_path,
        languages = { "vue" },
      },
    },
  },
  on_attach = function(client, bufnr)
    -- common.disableFormat(client)
    common.keyAttach(bufnr)
    common.navic(client, bufnr)
  end,
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
