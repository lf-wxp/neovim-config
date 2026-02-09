-- ╭────────────────────────────────────────────────────────╮
-- │    auto-session - Auto Session Management Config       │
-- │                                                        │
-- │ Purpose: Auto-save and restore Neovim sessions         │
-- │ Dependency: nvim-tree (optional)                       │
-- │ Features:                                              │
-- │   1. Auto-restore last opened session                  │
-- │   2. Close nvim-tree window before saving              │
-- │   3. Skip session save for certain filetypes           │
-- │   4. Provide Session Lens for session selection        │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  -- Session options
  vim.o.sessionoptions = "blank,buffers,help,tabpages,winsize,winpos,terminal,localoptions"

  require("auto-session").setup({
    log_level = "info",  -- Enable log output for debugging
    auto_restore_last_session = true,
    auto_save = true,
    auto_session_suppress_dirs = {
      "~/", "~/Downloads", "/", "/tmp", "~/Projects"
    },
    pre_save_cmds = {
      function()
        local ok, api = pcall(require, "nvim-tree.api")
        if ok then
          api.tree.close()
        end
      end
    },
    bypass_save_filetypes = { "alpha", "dashboard" },
    session_lens = {
      load_on_setup = true,
      theme_conf = { border = true },
      previewer = false,
    },
  })
end

return M
