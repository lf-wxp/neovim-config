local status, project = pcall(require, "project_nvim")
if not status then
  vim.notify("project_nvim not found")
  return
end

-- nvim-tree support
vim.g.nvim_tree_respect_buf_cwd = 1

project.setup({
  -- Project detection method: lsp first, then pattern
  detection_methods = { "lsp", "pattern" },
  -- Pattern files list (for identifying project root)
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
  -- Set to "global" to ensure global cwd is changed to project root
  scope_chdir = "global",
  -- Note: sync_root_with_cwd = false, let project.nvim detect project root and update cwd
  -- If set to true, it lets root follow cwd, which is the opposite behavior
  sync_root_with_cwd = false,
  -- Respect current buffer's cwd (set to false to let project.nvim take control)
  respect_buf_cwd = false,
  -- Whether to update project root when opening file
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  -- Silent mode, don't show project switch messages
  silent_chdir = true,
  -- Don't change directory when no project detected
  manual_mode = false,
})

local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("telescope not found")
  return
end
pcall(telescope.load_extension, "projects")
