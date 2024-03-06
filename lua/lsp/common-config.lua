local navic     = require("nvim-navic")
local keys      = require("keybindings")

local M         = {}

M.keyAttach     = function(bufnr)
  local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr })
  end
  -- 绑定快捷键
  -- map("n", keys.lsp.rename, "<cmd>Lspsaga rename<CR>")
  -- code action
  -- map("n", keys.lsp.code_action, "<cmd>Lspsaga code_action<CR>")
  -- go xx
  map("n", keys.lsp.go_definitiion, "<cmd>lua vim.lsp.buf.definition()<CR>")

  map("n", keys.lsp.hover_doc, "<cmd>Lspsaga hover_doc<cr>")
  -- scroll down hover doc or scroll in definition preview
  map("n", keys.lsp.hover_definition_scroll_up, "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>")
  -- scroll up hover doc
  map("n", keys.lsp.hover_definition_scroll_down, "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>")

  map("n", keys.lsp.go_declaration, "<cmd>lua vim.lsp.buf.declaration()<CR>")
  map("n", keys.lsp.go_implementation, "<cmd>lua vim.lsp.buf.implementation()<CR>")

  map("n", keys.lsp.references, "<cmd>Lspsaga lsp_finder<CR>")
  -- diagnostic
  map("n", keys.lsp.line_diagnostics, "<cmd>Lspsaga show_line_diagnostics<CR>")
  map("n", keys.lsp.next_diagnostics, "<cmd>Lspsaga diagnostic_jump_next<cr>")
  map("n", keys.lsp.prev_diagnostics, "<cmd>Lspsaga diagnostic_jump_prev<cr>")
  map("n", keys.lsp.format, "<cmd>lua vim.lsp.buf.format()<CR>")
end

-- 禁用格式化功能，交给专门插件插件处理
M.disableFormat = function(client)
  if vim.fn.has("nvim-0.8") == 1 then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  else
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
end

M.capabilities  = require("cmp_nvim_lsp").default_capabilities()

M.flags         = {
  debounce_text_changes = 150,
}

M.navic         = function(client, bufnr)
  navic.attach(client, bufnr)
end

return M
