-- ╭──────────────────────────────────────────────────────────╮
-- │                    Neovim Config Entry                   │
-- │                                                          │
-- │  Startup Order:                                          │
-- │    1. Leader keys (must be before lazy.nvim)             │
-- │    2. Core options + Neovide config                      │
-- │    3. Plugin manager (lazy.nvim auto-loads lua/plugins/) │
-- │    4. Deferred: autocmds, commands, keymap validator     │
-- │    5. VeryLazy: global keymaps                           │
-- ╰──────────────────────────────────────────────────────────╯

-- Guard: Require Neovim 0.11+
if vim.fn.has("nvim-0.11") ~= 1 then
  vim.api.nvim_echo({
    { "This config requires Neovim >= 0.11. Please upgrade.\n", "ErrorMsg" },
  }, true, {})
  return
end

-- ╭──────────────────────────────────────────────────────────╮
-- │  IMPORTANT: Set leader keys BEFORE loading lazy.nvim    │
-- ╰──────────────────────────────────────────────────────────╯
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load essential configs first (order matters)
require("config.options")   -- Vim options (encoding, indent, UI, etc.)
require("config.neovide")   -- Neovide-specific config (no-op in terminal)
require("config.lazy")      -- Plugin manager (auto-load lua/plugins/)

-- Defer non-essential configs for faster startup
vim.schedule(function()
  require("config.autocmds")                  -- Auto commands
  require("config.commands").setup()           -- User commands

  -- Lazy-load keymap validator: only load module when command is invoked
  vim.api.nvim_create_user_command("KeymapValidate", function(opts)
    require("config.keymap-validator").run(opts.bang)
  end, {
    bang = true,
    desc = "Validate keymap conflicts (! for statistics)",
  })
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
