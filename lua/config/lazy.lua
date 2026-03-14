-- ╭────────────────────────────────────────────────────────╮
-- │                lazy.nvim Bootstrap                     │
-- │                                                        │
-- │ Responsibilities:                                      │
-- │   1. Enable Lua module loader cache                    │
-- │   2. Auto-install lazy.nvim if not found               │
-- │   3. Load all plugin specs from lua/plugins/           │
-- │   4. Configure defaults and performance settings       │
-- ╰────────────────────────────────────────────────────────╯

-- Enable Lua module loader optimization (~50ms startup improvement)
vim.loader.enable()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    return
  end
end

vim.opt.rtp:prepend(lazypath)

-- Load all plugin configs from lua/plugins/
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- Auto load all files in lua/plugins/
  },
  defaults = {
    lazy = true,           -- Plugins are lazy-loaded by default (performance)
    version = false,       -- Always use latest commit, not version tags
  },
  install = {
    colorscheme = { "zephyr", "catppuccin", "gruvbox", "kanagawa" },
  },
  checker = {
    enabled = false, -- Disable auto update check (reduces network IO on startup)
  },
  change_detection = {
    enabled = true,  -- Auto-detect config file changes
    notify = false,  -- Don't notify on config change (reduces noise)
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",       -- Replaced by nvim-treesitter matchup / flash.nvim
        "matchparen",    -- Replaced by rainbow-delimiters.nvim（彩色括号匹配）
        "netrwPlugin",   -- Replaced by oil.nvim / nvim-tree
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
