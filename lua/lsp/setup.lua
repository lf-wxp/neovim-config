require("lsp.common")
require("lsp.ui")

local status, mason = pcall(require, "mason")
if not status then
  vim.notify("没有找到 mason")
  return
end

local status, mason_config = pcall(require, "mason-lspconfig")
if not status then
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
  -- 确保安装，根据需要填写
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
  },
})

-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  vue_ls = require("lsp.config.vue"),
  vtsls = require("lsp.config.ts"),
  lua_ls = require("lsp.config.lua"),
  rust_analyzer = require("lsp.config.rust"),
  jsonls = require("lsp.config.json"),
  cssls = require("lsp.config.css"),
  zk = nil,
  taplo = nil,
  html = nil,
}
-- 自动安装 Language Servers
for name, config in pairs(servers) do
  if config ~= nil then
    vim.lsp.config(name, config)
  else
    -- 使用默认参数
    vim.lsp.enable(name)
  end
end
