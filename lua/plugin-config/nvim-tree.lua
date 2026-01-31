local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
  vim.notify("nvim-tree not found")
  return
end

local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.3  -- You can change this too

-- List operation keymaps
nvim_tree.setup({
  sort = {
    sorter = "case_sensitive",
  },
  -- Don't show git status icons
  git = {
    enable = true,
  },
  -- Integration config with project.nvim
  -- Let nvim-tree sync to project.nvim detected project root
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  -- Hide dotfiles and node_modules folder
  filters = {
    -- dotfiles = true,
    -- custom = { 'node_modules' },
  },
  view = {
    number = false,
    relativenumber = false,
    -- Show icons
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
      -- Resize window on first open
      resize_window = true,
      -- Close on file open
      quit_on_open = true,
    },
  },
  -- wsl install -g wsl-open
  -- https://github.com/4U6U57/wsl-open/
  system_open = {
    cmd = 'open', -- Set to 'open' for mac
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
    },
    -- Hide root directory
    root_folder_label = false,
  },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    -- Important: When you supply an `on_attach` function, nvim-tree won't
    -- automatically set up the default keymaps. To set up the default keymaps,
    -- call the `default_on_attach` function. See `:help nvim-tree-quickstart-custom-mappings`.
    api.config.mappings.default_on_attach(bufnr)

    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    local preview = require('nvim-tree-preview')

    preview.setup({
      border = 'solid',
    });

    vim.keymap.set('n', 'P', preview.watch, opts 'Preview (Watch)')
    vim.keymap.set('n', '<Esc>', preview.unwatch, opts 'Close Preview/Unwatch')
    vim.keymap.set('n', '<C-d>', function() return preview.scroll(4) end, opts 'Scroll Down')
    vim.keymap.set('n', '<C-u>', function() return preview.scroll(-4) end, opts 'Scroll Up')

    -- Option A: Smart tab behavior: Only preview files, expand/collapse directories (recommended)
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

    -- Option B: Simple tab behavior: Always preview
    -- vim.keymap.set('n', '<Tab>', preview.node_under_cursor, opts 'Preview')
  end,
})
-- Auto close
-- vim.cmd([[
--   autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
-- ]])
