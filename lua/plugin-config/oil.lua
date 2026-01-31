-- oil.nvim 配置 - 以 buffer 方式编辑文件系统
local oil = require("oil")

oil.setup({
  -- 默认文件浏览器
  default_file_explorer = false, -- 保留 nvim-tree 作为默认

  -- 列显示
  columns = {
    "icon",
    -- "permissions",
    "size",
    -- "mtime",
  },

  -- Buffer 选项
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },

  -- 窗口选项
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
  },

  -- 删除到回收站
  delete_to_trash = true,

  -- 跳过确认简单操作
  skip_confirm_for_simple_edits = true,

  -- 选择文件时提示保存
  prompt_save_on_select_new_entry = true,

  -- 清理缓存
  cleanup_delay_ms = 2000,

  -- LSP 文件操作支持
  lsp_file_methods = {
    timeout_ms = 1000,
    autosave_changes = false,
  },

  -- 约束光标在文件名列
  constrain_cursor = "editable",

  -- watch_for_changes = false,

  -- 快捷键
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },

  -- 使用默认快捷键
  use_default_keymaps = true,

  -- 视图选项
  view_options = {
    show_hidden = true,
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    is_always_hidden = function(name, bufnr)
      return false
    end,
    natural_order = true,
    sort = {
      { "type", "asc" },
      { "name", "asc" },
    },
  },

  -- 浮动窗口配置
  float = {
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = "solid",
    win_options = {
      winblend = 0,
    },
  },

  -- 预览窗口配置
  preview = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = 0.9,
    min_height = { 5, 0.1 },
    height = nil,
    border = "solid",
    win_options = {
      winblend = 0,
    },
    update_on_cursor_moved = true,
  },

  -- 进度条配置
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = "solid",
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
})

-- 快捷键已统一收敛到 keybindings.lua 中
