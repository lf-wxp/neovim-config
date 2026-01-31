require("lsp.common")
require("lsp.ui")

local status, mason = pcall(require, "mason")
if not status then
  vim.notify("没有找到 mason")
  return
end

local status2, mason_config = pcall(require, "mason-lspconfig")
if not status2 then
  vim.notify("没有找到 mason-lspconfig")
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

mason_config.setup({
  ensure_installed = {
    "cssls",
    "html",
    "jsonls",
    "rust_analyzer",
    "taplo",
    "vue_ls",
    "lua_ls",
    "vtsls",
    "zk",
    "oxlint",
    "tailwindcss"
  },
})

-- 语言服务器配置
-- 有自定义配置的服务器
local servers_with_config = {
  vue_ls = "lsp.config.vue",
  vtsls = "lsp.config.ts",
  lua_ls = "lsp.config.lua",
  rust_analyzer = "lsp.config.rust",
  jsonls = "lsp.config.json",
  cssls = "lsp.config.css",
}

-- 使用默认配置的服务器
local default_servers = {
  "zk", "taplo", "html", "oxlint", "tailwindcss"
}

-- 加载自定义配置
for name, config_path in pairs(servers_with_config) do
  local ok, config = pcall(require, config_path)
  if ok then
    vim.lsp.config(name, config)
  else
    vim.notify("LSP 配置加载失败: " .. config_path, vim.log.levels.WARN)
  end
end

-- 启用默认配置服务器
for _, name in ipairs(default_servers) do
  vim.lsp.enable(name)
end
