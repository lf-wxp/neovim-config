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
  -- IMPORTANT: explicitly null out the `root_dir` function from
  -- nvim-lspconfig's bundled `lsp/oxlint.lua`. `vim.lsp.config()` deep-merges
  -- our opts with that bundled config, and the bundled `root_dir` ends up
  -- calling `util.insert_package_json` -> `string.find`, which throws:
  --   "bad argument #1 to 'find' (string expected, got table)"
  -- With `root_dir` set to nil, `root_markers` below takes over root detection,
  -- which is simpler and more predictable.
  root_dir = nil,
  -- Also null out the bundled `before_init` (it relies on `root_dir`) and
  -- relax `workspace_required` so the server still starts when there is no
  -- `.oxlintrc.json` at the project root.
  before_init = nil,
  workspace_required = false,
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
