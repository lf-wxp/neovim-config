-- ╭──────────────────────────────────────────────────────────╮
-- │                     LSP Setup                             │
-- │                                                             │
-- │ 用途: 配置和管理 LSP 服务器                                  │
-- │ 依赖: lsp.common, lsp.ui, lsp.config/*                     │
-- │ 功能:                                                       │
-- │   1. 加载通用 LSP 配置和 UI 设置                            │
-- │   2. 配置各个语言的 LSP 服务器                             │
-- │   3. 启用默认的无配置服务器                                │
-- ╰──────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  -- 使用 pcall 确保模块存在
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
  }

  local default_servers = {
    "zk",
    "taplo",
    "html",
    "oxlint",
    "tailwindcss",
  }

  -- 加载带配置的服务器，失败时提供详细错误信息
  for name, config_path in pairs(servers_with_config) do
    local ok, config = pcall(require, config_path)
    if ok then
      vim.lsp.config(name, config)
    else
      vim.notify(
        string.format("LSP config load failed: %s for server %s", config_path, name),
        vim.log.levels.WARN
      )
    end
  end

  -- 启用默认服务器
  for _, name in ipairs(default_servers) do
    vim.lsp.enable(name)
  end
end

return M
