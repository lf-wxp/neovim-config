local navic     = require("nvim-navic")
local keys      = require("keybindings")

local M         = {}

M.keyAttach     = function(bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
  end
  -- 绑定快捷键
  -- map("n", keys.lsp.rename, "<cmd>Lspsaga rename<cr>")
  -- code action
  -- map("n", keys.lsp.code_action, "<cmd>Lspsaga code_action<cr>")
  -- go xx
  map("n", keys.lsp.go_definitiion, "<cmd>lua vim.lsp.buf.definition()<cr>", "lsp definition")

  map("n", keys.lsp.hover_doc, "<cmd>Lspsaga hover_doc<cr>", "lst hover doc")

  map("n", keys.lsp.go_declaration, "<cmd>lua vim.lsp.buf.declaration()<cr>", "lsp declaration")
  map("n", keys.lsp.go_implementation, "<cmd>lua vim.lsp.buf.implementation()<cr>", "lsp implementation")

  map("n", keys.lsp.references, "<cmd>Lspsaga finder<cr>", "lsp references")
  -- diagnostic
  map("n", keys.lsp.line_diagnostics, "<cmd>Lspsaga show_line_diagnostics<cr>", "lsp diagnostic")
  map("n", keys.lsp.next_diagnostics, "<cmd>Lspsaga diagnostic_jump_next<cr>", "lsp diagnostic nextg")
  map("n", keys.lsp.prev_diagnostics, "<cmd>Lspsaga diagnostic_jump_prev<cr>", "lsp diagnostic prev")
  map("n", keys.lsp.format, "<cmd>lua vim.lsp.buf.format()<cr>", "lsp format")
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
