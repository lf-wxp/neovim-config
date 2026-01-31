local status, lspsaga = pcall(require, "lspsaga")
if not status then
  vim.notify("没有找到 lspsaga")
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
  -- 禁用 lspsaga 的 winbar，使用原生方案
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
  -- rename 配置（替代 inc-rename）
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
  -- code action 配置（替代 actions-preview）
  code_action = {
    num_shortcut = true,
    show_server_name = true,
    extend_gitsigns = false,
    keys = {
      quit = 'q',
      exec = '<CR>',
    },
  },
  -- lightbulb 配置
  lightbulb = {
    enable = true,
    sign = true,
    virtual_text = false,
  },
  -- peek definition 配置（替代 goto-preview）
  peek_definition = {
    width = 0.9,
    height = 0.8,
  },
  -- outline 配置
  outline = {
    win_position = 'right',
    win_width = 30,
    auto_preview = true,
    detail = true,
  },
})
