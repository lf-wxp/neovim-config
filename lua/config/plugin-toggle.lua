-- ╭────────────────────────────────────────────────────────╮
-- │              Plugin Toggle Configuration               │
-- │                                                        │
-- │ Centralized plugin enable/disable management.          │
-- │ All plugins are ENABLED by default.                    │
-- │ Only add entries here to DISABLE specific plugins      │
-- │ by setting them to false.                              │
-- │                                                        │
-- │ Usage:                                                 │
-- │   In plugin spec, add:                                 │
-- │   enabled = require("config.plugin-toggle")            │
-- │              .is_enabled("plugin-name")                │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

--- Plugin toggle table (organized by category)
--- key: plugin short name (matches the comment title in spec files)
--- value: true = enabled, false = disabled
--- NOTE: Only add plugins you want to DISABLE (set to false).
---       Unlisted plugins are enabled by default.
---@type table<string, boolean>
M.plugins = {
  -- ── Coding (coding.lua) ──────────────────────────────
    ["codecompanion"] = false,    -- Disable AI assistant
  -- ── Colorscheme (colorscheme.lua) ────────────────────
  -- ── Editor (editor.lua) ──────────────────────────────
  -- ── Formatting (formatting.lua) ──────────────────────
  -- ── Git (git.lua) ────────────────────────────────────
  -- ── Lang (lang.lua) ──────────────────────────────────
  -- ── LSP (lsp.lua) ────────────────────────────────────
  -- ── Navigation (navigation.lua) ──────────────────────
  -- ── UI (ui.lua) ──────────────────────────────────────
}

--- Check if a plugin is enabled
---@param name string Plugin name (key in M.plugins table)
---@return boolean
M.is_enabled = function(name)
  -- Unlisted plugins are enabled by default
  if M.plugins[name] == nil then
    return true
  end
  return M.plugins[name]
end

return M
