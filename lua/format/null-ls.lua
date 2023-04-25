local status, null_ls = pcall(require, "null-ls")
if not status then
  vim.notify("没有找到 null-ls")
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  debug = false,
  sources = {
    -- Formatting ---------------------
    --  brew install shfmt
    formatting.shfmt,
    -- StyLua
    -- brew install stylua
    formatting.stylua,
    -- frontend
    -- npm install -g @fsouza/prettierd
    -- brew install fsouza/prettierd/prettierd
    -- formatting.prettier_d,
    -- formatting.prettier.with({ -- 比默认少了 markdown
    --   filetypes = {
    --     "javascript",
    --     "javascriptreact",
    --     "typescript",
    --     "typescriptreact",
    --     "vue",
    --     "css",
    --     "scss",
    --     "less",
    --     "html",
    --     "json",
    --     "yaml",
    --     "graphql",
    --   },
    --   timeout = 10000,
    --   prefer_local = "node_modules/.bin",
    -- }),
    formatting.eslint_d,
    -- rustfmt
    formatting.rustfmt,
    -----------------------------------------------------
    -- json
    -- npm install -g fixjson
    formatting.fixjson,
    -----------------------------------------------------
    -- Diagnostics  ---------------------
    diagnostics.eslint_d,
    -- npm install -g cspell@latest
    diagnostics.cspell,
    -- code actions ---------------------
    code_actions.cspell,
    code_actions.gitsigns,
    code_actions.eslint_d,
    require("typescript.extensions.null-ls.code-actions"),
  },
  -- #{m}: message
  -- #{s}: source name (defaults to null-ls if not specified)
  -- #{c}: code (if available)
  diagnostics_format = "[#{s}] #{m}",
  on_attach = function(_)
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()']])
  end,
})
