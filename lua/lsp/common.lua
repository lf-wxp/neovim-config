local keys  = require("keybindings")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_buf_conf", { clear = true }),
  callback = function(event_context)
    local client = vim.lsp.get_client_by_id(event_context.data.client_id)
    -- vim.print(client.name, client.server_capabilities)
    if not client then
      return
    end

    local bufnr = event_context.buf
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
    end

    -- 绑定快捷键
    -- map("n", keys.lsp.rename, "<cmd>Lspsaga rename<cr>")
    map("n", keys.lsp.go_definitiion, "<cmd>Lspsaga goto_definition<cr>", "lsp definition")

    map("n", keys.lsp.hover_doc, "<cmd>Lspsaga hover_doc<cr>", "lsp hover doc")

    map("n", keys.lsp.go_declaration, "<cmd>Lspsaga peek_definition<cr>", "lsp declaration")
    map("n", keys.lsp.go_implementation, "<cmd>Lspsaga finder<cr>", "lsp references")
    -- diagnostic
    map("n", keys.lsp.line_diagnostics, "<cmd>Lspsaga show_line_diagnostics<cr>", "lsp diagnostic")
    map("n", keys.lsp.next_diagnostics, "<cmd>Lspsaga diagnostic_jump_next<cr>", "lsp diagnostic nextg")
    map("n", keys.lsp.prev_diagnostics, "<cmd>Lspsaga diagnostic_jump_prev<cr>", "lsp diagnostic prev")
    -- map("n", keys.lsp.format, "<cmd>lua vim.lsp.buf.format()<cr>", "lsp format")
    map("n", keys.lsp.format, "<cmd>lua require('conform').format()<cr>", "lsp format")

    -- Uncomment code below to enable inlay hint from language server, some LSP server supports inlay hint,
    -- but disable this feature by default, so you may need to enable inlay hint in the LSP server config.
    -- vim.lsp.inlay_hint.enable(true, {buffer=bufnr})

    -- The blow command will highlight the current variable and its usages in the buffer.
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

-- Enable lsp servers when they are available

local capabilities = require("lsp.utils").get_default_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 500,
  },
})
