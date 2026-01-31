-- https://github.com/rmagatti/auto-session
-- Note: Removed curdir, let project.nvim manage working directory
-- So Telescope and other tools will search from project root
-- Note: Removed folds, avoid default folding issue caused by cross-session fold state
vim.o.sessionoptions = "blank,buffers,help,tabpages,winsize,winpos,terminal,localoptions"

require("auto-session").setup({
  -- Auto load last saved session
  -- auto_session_enable_last_session = true,
  -- Auto close nvim-tree when saving session
  -- Because nvim-tree will break session saving
  -- if it's open
  pre_save_cmds = { "tabdo NvimTreeClose" },
  bypass_save_filetypes = { "alpha", "dashboard" },
  auto_restore_last_session = true,
})

