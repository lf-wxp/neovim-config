-- ╭────────────────────────────────────────────────────────╮
-- │         typos-lsp - Spell Checking LSP Configuration   │
-- ╰────────────────────────────────────────────────────────╯

local disabled_filetypes = {
  "lock",
  "log",
  "help",
  "lazy",
  "mason",
  "neo-tree",
}

local opts = {
  cmd = { "typos-lsp" },
  -- No filetypes field: typos-lsp attaches to ALL file types by default
  root_markers = { "typos.toml", "_typos.toml", ".typos.toml", ".git" },
  init_options = {
    -- Severity: Error, Warning, Information, Hint
    diagnosticSeverity = "Warning",
  },
  on_attach = function(client, bufnr)
    local ft = vim.bo[bufnr].filetype
    local buf_name = vim.api.nvim_buf_get_name(bufnr)

    -- Detach for lock files (package-lock.json, yarn.lock, etc.)
    if buf_name:match("%.lock$") or buf_name:match("lock%.json$") then
      vim.defer_fn(function()
        vim.lsp.buf_detach_client(bufnr, client.id)
      end, 0)
      return
    end

    -- Detach for configured filetypes
    if vim.tbl_contains(disabled_filetypes, ft) then
      vim.defer_fn(function()
        vim.lsp.buf_detach_client(bufnr, client.id)
      end, 0)
      return
    end
  end,
}

return opts
