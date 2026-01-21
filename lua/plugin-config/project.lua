local status, project = pcall(require, "project_nvim")
if not status then
  vim.notify("没有找到 project_nvim")
  return
end

-- nvim-tree 支持
vim.g.nvim_tree_respect_buf_cwd = 1

project.setup({
  -- 项目检测方法：lsp 优先，然后是 pattern
  detection_methods = { "lsp", "pattern" },
  -- 特征文件列表（用于识别项目根目录）
  patterns = {
    "README.md",
    "Cargo.toml",
    "package.json",
    ".sln",
    ".git",
    "_darcs",
    ".hg",
    ".bzr",
    ".svn",
    "Makefile",
  },
  -- 设置为 "global" 确保全局 cwd 被更改为项目根目录
  scope_chdir = "global",
  -- 注意：sync_root_with_cwd = false，让 project.nvim 检测项目根目录并更新 cwd
  -- 如果设为 true，则是让根目录跟随 cwd，这是相反的行为
  sync_root_with_cwd = false,
  -- 尊重当前 buffer 的 cwd（设为 false 让 project.nvim 主导）
  respect_buf_cwd = false,
  -- 当打开文件时是否更新项目根目录
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  -- 静默模式，不显示切换项目的消息
  silent_chdir = true,
  -- 当没有检测到项目时不改变目录
  manual_mode = false,
})

local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("没有找到 telescope")
  return
end
pcall(telescope.load_extension, "projects")
