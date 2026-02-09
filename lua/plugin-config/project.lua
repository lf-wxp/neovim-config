-- ╭────────────────────────────────────────────────────────╮
-- │         project.nvim - Project Root Detection Config   │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local project = require("project_nvim")

  -- nvim-tree support
  vim.g.nvim_tree_respect_buf_cwd = 1

  project.setup({
    detection_methods = { "lsp", "pattern" },
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
    scope_chdir = "global",
    sync_root_with_cwd = false,
    respect_buf_cwd = false,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    silent_chdir = true,
    manual_mode = false,
  })

  -- Telescope extension
  local ok, telescope = pcall(require, "telescope")
  if ok then
    pcall(telescope.load_extension, "projects")
  end
end

return M
