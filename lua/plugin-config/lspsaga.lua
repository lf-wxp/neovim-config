-- ╭────────────────────────────────────────────────────────╮
-- │        lspsaga.nvim - LSP UI Enhancement Config        │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  require("lspsaga").setup({
    scroll_preview = {
      scroll_down = 'sd',
      scroll_up = 'su',
    },
    ui = {
      border = 'solid',
      code_action = '! ',
    },
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
    code_action = {
      num_shortcut = true,
      show_server_name = true,
      extend_gitsigns = false,
      keys = {
        quit = 'q',
        exec = '<CR>',
      },
    },
    lightbulb = {
      enable = true,
      sign = true,
      virtual_text = false,
    },
    peek_definition = {
      width = 0.9,
      height = 0.8,
    },
    outline = {
      win_position = 'right',
      win_width = 30,
      auto_preview = true,
      detail = true,
    },
  })
end

return M
