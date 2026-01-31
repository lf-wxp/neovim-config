local status, lspsaga = pcall(require, "lspsaga")
if not status then
  vim.notify("lspsaga not found")
  return
end

lspsaga.setup({
  scroll_preview = {
    scroll_down = 'sd',
    scroll_up = 'su',
  },
  ui = {
    border = 'solid',
    code_action = '💡',
  },
  -- Disable lspsaga winbar, use native solution
  symbol_in_winbar = {
    enable = false,
  },
  finder = {
    keys = {
      vsplit = 'v',
      shuttle = '<leader>ww'
    },
    max_height = 0.7,
    left_width = 0.3,
    right_width = 0.6,
  },
  definition = {
    keys = {
      vsplit = 'v',
      shuttle = '<leader>ww'
    },
    width = 0.9,
    height = 0.8,
  },
  -- Rename config (replaces inc-rename)
  rename = {
    in_select = true,
    auto_save = false,
    project_max_width = 0.5,
    project_max_height = 0.5,
    keys = {
      quit = '<C-c>',
      exec = '<CR>',
      select = 'x',
    },
  },
  -- Code action config (replaces actions-preview)
  code_action = {
    num_shortcut = true,
    show_server_name = true,
    extend_gitsigns = false,
    keys = {
      quit = 'q',
      exec = '<CR>',
    },
  },
  -- Lightbulb config
  lightbulb = {
    enable = true,
    sign = true,
    virtual_text = false,
  },
  -- Peek definition config (replaces goto-preview)
  peek_definition = {
    width = 0.9,
    height = 0.8,
  },
  -- Outline config
  outline = {
    win_position = 'right',
    win_width = 30,
    auto_preview = true,
    detail = true,
  },
})
