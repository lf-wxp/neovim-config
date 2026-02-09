-- ╭──────────────────────────────────────────────────────────╮
-- │                    Neovim Config Entry                   │
-- ╰──────────────────────────────────────────────────────────╯

-- ╭──────────────────────────────────────────────────────────╮
-- │  IMPORTANT: Set leader keys BEFORE loading lazy.nvim    │
-- ╰──────────────────────────────────────────────────────────╯
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load essential configs first (order matters)
require("config.options")   -- vim options
require("config.neovide")   -- Neovide specific config
require("config.lazy")      -- plugin manager (auto-load lua/plugins/)

-- Delay load non-essential configs for faster startup
vim.schedule(function()
  require("config.autocmds")                  -- auto commands
  require("config.commands").setup()           -- user commands
  require("config.keymap-validator").setup()  -- keymap conflict detection
end)

-- Load global keymaps after VeryLazy event for better startup performance
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.keymaps").load_global()
  end,
  once = true,
  desc = "Load global keymaps after UI initialization",
})
