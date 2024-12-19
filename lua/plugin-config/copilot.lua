local status, copilot = pcall(require, "copilot")
if not status then
  vim.notify("没有找到 copilot")
  return
end

copilot.setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "<leader>xk",
      jump_next = "<leader>xj",
      accept = "<leader>xa",
      refresh = "<leader>xr",
      open = "<leader>xo"
    },
    layout = {
      position = "bottom", -- | top | left | right | horizontal | vertical
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = false,
    hide_during_completion = true,
    debounce = 75,
    keymap = {
      accept = "<leader>xa",
      accept_word = false,
      accept_line = false,
      next = "<leader>xl",
      prev = "<leader>xh",
      dismiss = "<leader>xd",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 18.x
  server_opts_overrides = {},
})
