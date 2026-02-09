-- ╭────────────────────────────────────────────────────────╮
-- │         oxlint - Fast JavaScript/TypeScript Linter     │
-- ╰────────────────────────────────────────────────────────╯

local opts = {
  cmd = { "oxc_language_server" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "astro",
    "javascript.jsx",
    "typescript.tsx",
  },
  root_markers = { ".oxlintrc.json", "package.json", ".git" },
  on_attach = function(client, bufnr)
    -- Register fixAll code action command
    vim.api.nvim_buf_create_user_command(bufnr, "LspOxlintFixAll", function()
      client:exec_cmd({
        title = "Apply Oxlint automatic fixes",
        command = "oxc.fixAll",
        arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
      })
    end, {
      desc = "Apply Oxlint automatic fixes",
    })
  end,
  init_options = {
    settings = {
      run = "onType",
    },
  },
}

return opts
