-- ╭────────────────────────────────────────────────────────╮
-- │         oxlint - Fast JavaScript/TypeScript Linter     │
-- │                                                        │
-- │ oxlint v1.x has built-in --lsp mode, ESLint-compatible  │
-- │ Supports .oxlintrc.json and eslint.config.* config files │
-- ╰────────────────────────────────────────────────────────╯

local opts = {
  -- oxlint v1.x uses `oxlint --lsp` to start the built-in language server
  -- (legacy version used standalone oxc_language_server binary, now deprecated)
  cmd = { "oxlint", "--lsp" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "astro",
  },
  root_markers = {
    -- oxlint native config
    ".oxlintrc.json",
    "oxlint.json",
    -- ESLint-compatible config (oxlint reads automatically)
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    ".eslintrc.json",
    ".eslintrc.js",
    ".eslintrc.cjs",
    -- Common project markers
    "package.json",
    ".git",
  },
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
