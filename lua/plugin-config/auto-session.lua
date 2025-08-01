-- https://github.com/rmagatti/auto-session
-- 推荐设置
local status, auto_session = pcall(require, "auto-session")
if not status then
    vim.notify("没有找到 auto-session")
  return
end

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

auto_session.setup(
  {
    -- 自动加载最后保存的一次会话
    -- auto_session_enable_last_session = true,
    -- 保存会话时自动关闭 nvim-tree
    -- 这是因为 nvim-tree 如果处于开启
    -- 状态，会破坏会话的保存
    pre_save_cmds = { "tabdo NvimTreeClose" },
    bypass_save_filetypes = { 'alpha', 'dashboard' }, -- or whatever dashboard you use
    auto_restore_last_session = true,
  }
)

