-- ╭────────────────────────────────────────────────────────╮
-- │                   LSP Setup                            │
-- │                                                        │
-- │ Purpose: Configure and manage LSP servers              │
-- │ Dependencies: lsp.common, lsp.ui, lsp.config/*         │
-- │ Features:                                              │
-- │   1. Load common LSP config and UI settings            │
-- │   2. Configure language-specific LSP servers           │
-- │   3. Enable default servers without extra config       │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  -- Use pcall to ensure modules exist
  local ok_common = pcall(require, "lsp.common")
  if not ok_common then
    vim.notify("Failed to load lsp.common", vim.log.levels.ERROR)
  end

  local ok_ui = pcall(require, "lsp.ui")
  if not ok_ui then
    vim.notify("Failed to load lsp.ui", vim.log.levels.ERROR)
  end

  local servers_with_config = {
    vue_ls = "lsp.config.vue",
    vtsls = "lsp.config.ts",
    lua_ls = "lsp.config.lua",
    rust_analyzer = "lsp.config.rust",
    jsonls = "lsp.config.json",
    cssls = "lsp.config.css",
    typos_lsp = "lsp.config.typos",
    oxlint = "lsp.config.oxlint",
  }

  local default_servers = {
    "zk",
    "taplo",
    "html",
    "tailwindcss",
  }

  -- Load servers with config, provide detailed error info on failure
  for name, config_path in pairs(servers_with_config) do
    local ok, config = pcall(require, config_path)
    if ok then
      vim.lsp.config(name, config)
      vim.lsp.enable(name)
    else
      vim.notify(
        string.format("LSP config load failed: %s for server %s", config_path, name),
        vim.log.levels.WARN
      )
    end
  end

  -- Enable default servers (no extra config needed)
  for _, name in ipairs(default_servers) do
    vim.lsp.enable(name)
  end
end

return M
