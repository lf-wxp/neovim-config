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

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  vim.notify("没有找到 lspconfig")
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
    "tsserver",
    "html",
    "jsonls",
    "rust_analyzer",
    "taplo",
    "volar",
    "lua_ls",
    "zk",
    -- "eslint"
  },
})

-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  lua_ls = require("lsp.config.lua"),
  rust_analyzer = require("lsp.config.rust"),
  -- denols = require("lsp.config.deno"),
  jsonls = require("lsp.config.json"),
  html = require("lsp.config.html"),
  volar = require("lsp.config.vue"),
  tsserver = require("lsp.config.ts"),
  cssls = require("lsp.config.css"),
  zk = require("lsp.config.markdown"),
  taplo = require("lsp.config.toml"),
  -- eslint = require("lsp.config.eslint"),
}
-- 自动安装 Language Servers
for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup({})
  end
end

require("lsp.ui")
