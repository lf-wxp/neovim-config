-- ╭────────────────────────────────────────────────────────╮
-- │                lazy.nvim Bootstrap                     │
-- ╰────────────────────────────────────────────────────────╯

-- Enable Lua module loader optimization (~50ms startup improvement)
vim.loader.enable()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Load all plugin configs
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- Auto load all files in lua/plugins/
  },
  defaults = {
    lazy = true,           -- Plugins are lazy by default (performance)
    version = false,       -- Don't lock version
  },
  install = {
    colorscheme = { "catppuccin", "gruvbox", "kanagawa" },
  },
  checker = {
    enabled = false, -- Disable auto update check (performance)
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
