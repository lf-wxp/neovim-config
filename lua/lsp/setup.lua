-- ╭──────────────────────────────────────────────────────────╮
-- │                     LSP Setup                             │
-- ╰──────────────────────────────────────────────────────────╯

require("lsp.common")
require("lsp.ui")

-- Language server configuration
-- Servers with custom config
local servers_with_config = {
  vue_ls = "lsp.config.vue",
  vtsls = "lsp.config.ts",
  lua_ls = "lsp.config.lua",
  rust_analyzer = "lsp.config.rust",
  jsonls = "lsp.config.json",
  cssls = "lsp.config.css",
}

-- Servers using default config
local default_servers = {
  "zk",
  "taplo",
  "html",
  "oxlint",
  "tailwindcss",
}

-- Load custom configurations
for name, config_path in pairs(servers_with_config) do
  local ok, config = pcall(require, config_path)
  if ok then
    vim.lsp.config(name, config)
  else
    vim.notify("LSP config load failed: " .. config_path, vim.log.levels.WARN)
  end
end

-- Enable default config servers
for _, name in ipairs(default_servers) do
  vim.lsp.enable(name)
end
