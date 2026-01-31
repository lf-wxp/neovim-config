-- ╭──────────────────────────────────────────────────────────╮
-- │                    Neovim Config Entry                    │
-- ╰──────────────────────────────────────────────────────────╯

-- Load config (order matters)
require("config.options")   -- vim options
require("config.keymaps")   -- global keymaps
require("config.neovide")   -- Neovide specific config
require("config.lazy")      -- plugin manager (auto-load lua/plugins/)
require("config.autocmds")  -- auto commands

-- LSP config is triggered by plugins/lsp.lua after plugin loading
