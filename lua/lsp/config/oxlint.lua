-- ╭────────────────────────────────────────────────────────╮
-- │         oxlint - Fast JavaScript/TypeScript Linter     │
-- │                                                        │
-- │ oxlint v1.x 内置 --lsp 模式，兼容 ESLint 配置         │
-- │ 支持 .oxlintrc.json 和 eslint.config.* 配置文件       │
-- ╰────────────────────────────────────────────────────────╯

local opts = {
  -- oxlint v1.x 使用 `oxlint --lsp` 启动内置 language server
  -- (旧版使用独立的 oxc_language_server 二进制文件，已废弃)
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
    -- oxlint 原生配置
    ".oxlintrc.json",
    "oxlint.json",
    -- ESLint 兼容配置 (oxlint 会自动读取)
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    ".eslintrc.json",
    ".eslintrc.js",
    ".eslintrc.cjs",
    -- 通用项目标记
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
