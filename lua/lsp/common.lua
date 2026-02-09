-- ╭────────────────────────────────────────────────────────╮
-- │                  LSP Common Config                     │
-- │                                                        │
-- │ Purpose: Configure LSP common behaviors and keymaps    │
-- │ Dependencies: config.keymaps, lsp.utils                │
-- │ Features:                                              │
-- │   1. Buffer keymaps on LspAttach                       │
-- │   2. Global LSP capabilities and config                │
-- │   3. Document highlight with LspDetach cleanup         │
-- │   4. Inlay hints toggle                                │
-- │   5. CodeLens auto-refresh and run                     │
-- ╰────────────────────────────────────────────────────────╯

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

    -- ╭─────────────────────────────────────────────────────╮
    -- │              Navigation Keymaps                     │
    -- ╰─────────────────────────────────────────────────────╯
    map("n", keys.lsp.go_definitiion, "<cmd>Lspsaga goto_definition<cr>", "Go to Definition")
    map("n", keys.lsp.hover_doc, "<cmd>Lspsaga hover_doc<cr>", "Hover Doc")
    map("n", keys.lsp.go_declaration, "<cmd>Lspsaga peek_definition<cr>", "Peek Declaration")
    map("n", keys.lsp.go_implementation, "<cmd>Lspsaga finder<cr>", "Find References")
    map("n", keys.lsp.type_definition, "<cmd>Lspsaga goto_type_definition<cr>", "Type Definition")
    map("n", keys.lsp.signature_help, vim.lsp.buf.signature_help, "Signature Help")

    -- ╭─────────────────────────────────────────────────────╮
    -- │              Diagnostics Keymaps                    │
    -- ╰─────────────────────────────────────────────────────╯
    map("n", keys.lsp.line_diagnostics, "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics")
    map("n", keys.lsp.next_diagnostics, "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next Diagnostic")
    map("n", keys.lsp.prev_diagnostics, "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Prev Diagnostic")

    -- ╭─────────────────────────────────────────────────────╮
    -- │              Symbols Keymaps                        │
    -- ╰─────────────────────────────────────────────────────╯
    map("n", keys.lsp.document_symbols, "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols")
    map("n", keys.lsp.workspace_symbols, "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols")

    -- ╭─────────────────────────────────────────────────────╮
    -- │              Format Keymaps                         │
    -- ╰─────────────────────────────────────────────────────╯
    map("n", keys.lsp.format, "<cmd>lua require('conform').format()<cr>", "Format")

    -- ╭─────────────────────────────────────────────────────╮
    -- │              Inlay Hints (Neovim 0.10+)             │
    -- ╰─────────────────────────────────────────────────────╯
    if client.supports_method("textDocument/inlayHint") then
      -- Enable inlay hints by default
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

      map("n", keys.lsp.toggle_inlay_hints, function()
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
        vim.notify("Inlay Hints " .. (not enabled and "enabled" or "disabled"), vim.log.levels.INFO)
      end, "Toggle Inlay Hints")
    end

    -- ╭─────────────────────────────────────────────────────╮
    -- │              CodeLens                               │
    -- ╰─────────────────────────────────────────────────────╯
    if client.supports_method("textDocument/codeLens") then
      -- Auto refresh codelens
      local codelens_gid = vim.api.nvim_create_augroup("lsp_codelens_" .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
        group = codelens_gid,
        buffer = bufnr,
        callback = function()
          vim.lsp.codelens.refresh({ bufnr = bufnr })
        end,
      })
      -- Initial refresh
      vim.lsp.codelens.refresh({ bufnr = bufnr })

      map("n", keys.lsp.codelens_run, vim.lsp.codelens.run, "CodeLens Run")
    end

    -- ╭─────────────────────────────────────────────────────╮
    -- │              Document Highlight                     │
    -- ╰─────────────────────────────────────────────────────╯
    if client.supports_method("textDocument/documentHighlight") then
      local highlight_gid = vim.api.nvim_create_augroup("lsp_document_highlight_" .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd("CursorHold", {
        group = highlight_gid,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.document_highlight()
        end,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = highlight_gid,
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

-- ╭────────────────────────────────────────────────────────╮
-- │                 LspDetach Cleanup                      │
-- ╰────────────────────────────────────────────────────────╯
vim.api.nvim_create_autocmd("LspDetach", {
  group = vim.api.nvim_create_augroup("lsp_buf_detach", { clear = true }),
  callback = function(event_context)
    local bufnr = event_context.buf
    -- Clean up document highlight augroup
    pcall(vim.api.nvim_del_augroup_by_name, "lsp_document_highlight_" .. bufnr)
    -- Clean up codelens augroup
    pcall(vim.api.nvim_del_augroup_by_name, "lsp_codelens_" .. bufnr)
    -- Clear references
    vim.lsp.buf.clear_references()
  end,
  desc = "Cleanup LSP buffer resources on detach",
})

-- ╭────────────────────────────────────────────────────────╮
-- │                 Global LSP Config                      │
-- ╰────────────────────────────────────────────────────────╯
local capabilities = require("lsp.utils").get_default_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150, -- Neovim default; 500ms was too slow for responsive diagnostics
  },
})
