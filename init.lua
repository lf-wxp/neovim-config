require('plugins')
require('basic')
require('colorscheme')
require('autocmds')
require('keybindings')
require("lsp.setup")
require("cmp.setup")
require("format.setup")

local TelescopePrompt = {
  TelescopePreviewNormal = {
      bg = '#2E323C',
  },
  TelescopePreviewBorder = {
      bg = '#2E323C',
  },
  TelescopeResultsNormal = {
      bg = '#23272e',
  },
  TelescopeResultsBorder = {
      bg = '#23272e',
  },
}
for hl, col in pairs(TelescopePrompt) do
  vim.api.nvim_set_hl(0, hl, col)
end
