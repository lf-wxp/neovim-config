-- ╭──────────────────────────────────────────────────────────╮
-- │                    LSP Common Config                      │
-- ╰──────────────────────────────────────────────────────────╯

local keys = require("config.keymaps")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_buf_conf", { clear = true }),
  callback = function(event_context)
    local client = vim.lsp.get_client_by_id(event_context.data.client_id)
    if not client then
      return
    end

    local bufnr = event_context.buf
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
    end

    -- Keymaps
    map("n", keys.lsp.go_definitiion, "<cmd>Lspsaga goto_definition<cr>", "Go to Definition")
    map("n", keys.lsp.hover_doc, "<cmd>Lspsaga hover_doc<cr>", "Hover Doc")
    map("n", keys.lsp.go_declaration, "<cmd>Lspsaga peek_definition<cr>", "Peek Declaration")
    map("n", keys.lsp.go_implementation, "<cmd>Lspsaga finder<cr>", "Find References")
    -- Diagnostics
    map("n", keys.lsp.line_diagnostics, "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics")
    map("n", keys.lsp.next_diagnostics, "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next Diagnostic")
    map("n", keys.lsp.prev_diagnostics, "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Prev Diagnostic")
    map("n", keys.lsp.format, "<cmd>lua require('conform').format()<cr>", "Format")

    -- Document highlight
    if client.server_capabilities.documentHighlightProvider then
      local gid = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
      vim.api.nvim_create_autocmd("CursorHold", {
        group = gid,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.document_highlight()
        end,
      })

      vim.api.nvim_create_autocmd("CursorMoved", {
        group = gid,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.clear_references()
        end,
      })
    end
  end,
  nested = true,
  desc = "Configure buffer keymap and behavior based on LSP",
})

-- Global LSP config
local capabilities = require("lsp.utils").get_default_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 500,
  },
})
