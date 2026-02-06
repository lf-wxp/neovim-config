-- ╭──────────────────────────────────────────────────────────╮
-- │       auto-session - Auto Session Management Config       │
-- │                                                             │
-- │ 用途: 自动保存和恢复 Neovim 会话                            │
-- │ 依赖: nvim-tree (可选)                                      │
-- │ 功能:                                                       │
-- │   1. 自动恢复上次打开的会话                                 │
-- │   2. 保存前关闭 nvim-tree 窗口                              │
-- │   3. 跳过特定文件类型的会话保存                             │
-- │   4. 提供 Session Lens 用于选择会话                         │
-- ╰──────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  -- Session options
  vim.o.sessionoptions = "blank,buffers,help,tabpages,winsize,winpos,terminal,localoptions"

  require("auto-session").setup({
    log_level = "info",  -- 启用日志输出以便调试
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
