-- ╭────────────────────────────────────────────────────────╮
-- │                   LSP Setup                            │
-- │                                                        │
-- │ Purpose: Configure and manage LSP servers              │
-- │ Dependencies: lsp.common, lsp.ui, lsp.config/*         │
-- │ Features:                                              │
-- │   1. Load common LSP config (keymaps, highlights)      │
-- │   2. Load UI config (diagnostics display)              │
-- │   3. Configure language-specific LSP servers           │
-- │   4. Enable default servers without extra config       │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

--- Servers with dedicated config files in lsp/config/
---@type table<string, string>
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

--- Servers that work well with default settings
---@type string[]
local default_servers = {
  "zk",
  "taplo",
  "html",
  "tailwindcss",
}

M.setup = function()
  -- Load common LSP config (keymaps, document highlight, codelens, etc.)
  local ok_common, err_common = pcall(require, "lsp.common")
  if not ok_common then
    vim.notify("Failed to load lsp.common: " .. tostring(err_common), vim.log.levels.ERROR)
  end

  -- Load UI config (diagnostic display, signs, floating windows)
  local ok_ui, err_ui = pcall(require, "lsp.ui")
  if not ok_ui then
    vim.notify("Failed to load lsp.ui: " .. tostring(err_ui), vim.log.levels.ERROR)
  end

  -- Load servers with dedicated config files
  for name, config_path in pairs(servers_with_config) do
    local ok, config = pcall(require, config_path)
    if ok then
      vim.lsp.config(name, config)
      vim.lsp.enable(name)
    else
      vim.notify(
        string.format("[LSP] Config load failed: %s (%s)", name, config_path),
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
