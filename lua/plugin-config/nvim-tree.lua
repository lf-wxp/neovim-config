-- ╭────────────────────────────────────────────────────────╮
-- │                 nvim-tree - File Tree Config           │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local nvim_tree = require("nvim-tree")

  local HEIGHT_RATIO = 0.8
  local WIDTH_RATIO = 0.3

  -- List operation keymaps
  nvim_tree.setup({
    sort = {
      sorter = "case_sensitive",
    },
    git = {
      enable = true,
    },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    filters = {
      -- dotfiles = true,
      -- custom = { 'node_modules' },
    },
    view = {
      number = false,
      relativenumber = false,
      signcolumn = 'yes',
      float = {
        enable = true,
        open_win_config = function()
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * WIDTH_RATIO
          local window_h = screen_h * HEIGHT_RATIO
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = (screen_w - window_w) / 2 - window_w / 2
          local center_y = ((vim.opt.lines:get() - window_h) / 2)
              - vim.opt.cmdheight:get()
          return {
            border = 'solid',
            relative = 'editor',
            row = center_y,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
      width = function()
        return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
      end,
    },
    actions = {
      open_file = {
        resize_window = true,
        quit_on_open = true,
      },
    },
    system_open = {
      cmd = 'open',
    },
    renderer = {
      indent_markers = {
        enable = false,
        icons = {
          corner = "└ ",
          edge = "│ ",
          none = "  ",
        },
      },
      icons = {
        webdev_colors = true,
        git_placement = "after",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          default = "󰈔",
          symlink = "󰉌",
          bookmark = "󰆃",
          modified = "󰏫",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "󰉋",
            open = "󰝰",
            empty = "󰉖",
            empty_open = "󰷏",
            symlink = "󰉋",
            symlink_open = "󰝰",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
      root_folder_label = false,
    },
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')
      api.config.mappings.default_on_attach(bufnr)

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      local status, preview = pcall(require, 'nvim-tree-preview')
      if not status then
        vim.notify("nvim-tree-preview not found", vim.log.levels.WARN)
      else
        preview.setup({
          border = 'solid',
        })

        vim.keymap.set('n', 'P', preview.watch, opts 'Preview (Watch)')
        vim.keymap.set('n', '<Esc>', preview.unwatch, opts 'Close Preview/Unwatch')
        vim.keymap.set('n', '<C-d>', function() return preview.scroll(4) end, opts 'Scroll Down')
        vim.keymap.set('n', '<C-u>', function() return preview.scroll(-4) end, opts 'Scroll Up')

        vim.keymap.set('n', '<Tab>', function()
          local ok, node = pcall(api.tree.get_node_under_cursor)
          if ok and node then
            if node.type == 'directory' then
              api.node.open.edit()
            else
              preview.node(node, { toggle_focus = true })
            end
          end
        end, opts 'Preview')
      end
    end,
  })
end

return M
