local keys = require("keybindings")
local status, typescript = pcall(require, "typescript")
if not status then
  vim.notify("没有找到 typescript")
  return
end

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

    --[[
        :TypescriptOrganizeImports
        :TypescriptRenameFile
        :TypescriptAddMissingImports
        :TypescriptRemoveUnused
        :TypescriptFixAll
        :TypescriptGoToSourceDefinition
    ]]

    local function map(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr })
    end
    map("n", keys.ts.organize_import, ":TypescriptOrganizeImports<CR>")
    map("n", keys.ts.rename_file, ":TypescriptRenameFile<CR>")
    map("n", keys.ts.add_missing_import, ":TypescriptAddMissingImports<CR>")
    map("n", keys.ts.remove_unused, ":TypescriptRemoveUnused<CR>")
  end,
}
return {
  on_setup = function(_)
    typescript.setup({
      disable_commands = false, -- prevent the plugin from creating Vim commands
      debug = false,            -- enable debug logging for commands
      go_to_source_definition = {
        fallback = true,        -- fall back to standard LSP definition on failure
      },
      server = opts,
    })
  end,
}
