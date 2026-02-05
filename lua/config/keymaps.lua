-- ╭──────────────────────────────────────────────────────────╮
-- │                      Global Keymaps                       │
-- ╰──────────────────────────────────────────────────────────╯

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

--- Helper function: create keymap with description
---@param mode string|table mode
---@param lhs string key
---@param rhs string|function action
---@param desc string description
local function map(mode, lhs, rhs, desc)
  keymap(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                      Window Management                    │
-- ╰──────────────────────────────────────────────────────────╯

-- Split
map("n", "<leader>sv", ":vsp<cr>", "Split Vertical")
map("n", "<leader>sh", ":sp<cr>", "Split Horizontal")
map("n", "<leader>sc", "<C-w>c", "Close Window")
map("n", "<leader>so", "<C-w>o", "Close Other Windows")

-- Equal window sizes
map("n", "<leader>s=", "<C-w>=", "Equal Windows")
-- Equal window sizes
map("n", "<leader>s=", "<C-w>=", "Equal Windows")

-- ╭──────────────────────────────────────────────────────────╮
-- │                      Edit Operations                      │
-- ╰──────────────────────────────────────────────────────────╯

-- Move selected text in Visual mode
map("v", "J", ":move '>+1<cr>gv-gv", "Move Selection Down")
map("v", "K", ":move '<-2<cr>gv-gv", "Move Selection Up")

-- Scroll
map("n", "<leader>u", "<Cmd>normal! <C-u>zz<CR>", "Scroll Up Half Page")
map("n", "<leader>d", "<Cmd>normal! <C-d>zz<CR>", "Scroll Down Half Page")
map("n", "<leader>b", "<Cmd>normal! <C-b>zz<CR>", "Scroll Up Full Page")

-- Clipboard
map({ "n", "v" }, "<leader>p", '"+p', "Paste from Clipboard")
map({ "n", "v" }, "<leader>y", '"+y', "Copy to Clipboard")

-- Clear search highlight
map("n", "<leader>k", ":noh<cr>", "Clear Search Highlight")

-- Navigation History
map("n", "<leader>o", "<C-o>", "Go Back")
map("n", "<leader>i", "<C-i>", "Go Forward")

-- ╭──────────────────────────────────────────────────────────╮
-- │                    Text Objects                           │
-- ╰──────────────────────────────────────────────────────────╯

-- Bracket aliases
map("o", "ir", "i[", "Inside []")
map("o", "ar", "a[", "Around []")
map("o", "ia", "i<", "Inside <>")
map("o", "aa", "a<", "Around <>")

-- ╭──────────────────────────────────────────────────────────╮
-- │                  Plugin Keymaps (Export)                  │
-- ╰──────────────────────────────────────────────────────────╯

-- Export keymap config for plugins
local M = {}

-- ╭──────────────────────────────────────────────────────────╮
-- │  Navigation - 文件导航相关插件                            │
-- ╰──────────────────────────────────────────────────────────╯

-- nvim-tree - 文件树
M.nvimTree = {
  toggle = "<leader>tt",
}

-- oil.nvim - 文件管理器
M.oil = {
  open = "-",
  open_float = "<leader>-",
}

-- telescope - 模糊搜索
M.telescope = {
  find_files = "<leader>ff",
  live_grep = "<leader>fg",
  projects = "<leader>fp",
  colorscheme = "<leader>fc",
  file_browser = "<leader>fe",
  keymaps = "<leader>fk",
  buffers = "<leader>fb",
  buffers_tab = "<Tab>",
}

-- harpoon - 快速文件切换
M.harpoon = {
  append = "<leader>na",
  toggle = "<leader>nt",
  next = "<leader>nn",
  prev = "<leader>np",
  n1 = "<leader>n1",
  n2 = "<leader>n2",
  n3 = "<leader>n3",
  n4 = "<leader>n4",
  n5 = "<leader>n5",
  n6 = "<leader>n6",
}

-- grug-far - 项目搜索替换
M.grugFar = {
  project = "<leader>rp",
  file = "<leader>rf",
  word = "<leader>rw",
}

-- ╭──────────────────────────────────────────────────────────╮
-- │  Buffer & UI - 标签页/UI相关                              │
-- ╰──────────────────────────────────────────────────────────╯

-- bufferline - 标签栏
M.bufferline = {
  prev_tab = "<leader>h",
  next_tab = "<leader>l",
  move_prev = "<leader><",
  move_next = "<leader>>",
  pick = "<leader>tp",
  close = "<leader>tc",
  close_right = "<leader>bcl",
  close_left = "<leader>bch",
  pick_close = "<leader>bc",
}

-- snacks.nvim - Dashboard/终端/缓冲区管理
M.snacks = {
  dashboard = "<leader> ;",
  bufdelete = "<leader>bd",
  bufdelete_other = "<leader>bo",
  terminal = "<c-/>",
}

-- smart-splits - 智能窗口管理
M.smartSplits = {
  -- 窗口导航
  move_left = "<leader>wh",
  move_down = "<leader>wj",
  move_up = "<leader>wk",
  move_right = "<leader>wl",
  -- 窗口调整大小
  resize_left = "<leader>s<",
  resize_right = "<leader>s>",
  resize_down = "<leader>s-",
  resize_up = "<leader>s+",
  -- 窗口大小相等 (全局快捷键)
  equal = "<leader>s=",
}

-- window - 基础窗口管理
M.window = {
  split_vertical = "<leader>sv",
  split_horizontal = "<leader>sh",
  close = "<leader>sc",
  close_other = "<leader>so",
}

-- ╭──────────────────────────────────────────────────────────╮
-- │  Editor - 编辑增强                                        │
-- ╰──────────────────────────────────────────────────────────╯

-- flash.nvim - 快速跳转
M.flash = {
  jump = "<leader>fj",
  treesitter = "<leader>ft",
}

-- treesj - 代码分合
M.treesj = {
  toggle = "<leader>cj",
}

-- sniprun - 代码运行
M.sniprun = {
  run = "<leader>cr",
}

-- yanky - 剪贴板历史
M.yanky = {
  paste_after = "p",
  paste_before = "P",
  g_paste_after = "gp",
  g_paste_before = "gP",
  cycle_next = "<c-n>",
  cycle_prev = "<c-p>",
  yank_history = "<leader>fy",
}

-- multicursor - 多光标
M.multicursor = {
  addCursorAbove = "<up>",
  addCursorBelow = "<down>",
  skipCursorAbove = "<leader><up>",
  skipCursorBelow = "<leader><down>",
  addNextMatch = "<leader>m",
  addPrevMatch = "<leader>M",
  skipNextMatch = "<leader>s",
  skipPrevMatch = "<leader>S",
  addCursorWithMouse = "<c-leftmouse>",
  toggleCursor = "<c-q>",
  prevCursor = "<left>",
  nextCursor = "<right>",
  deleteCursor = "<leader>x",
}

-- luasnip - 代码片段
M.snip = {
  expand_jumpable = "<C-l>",
  jumpable = "<C-h>",
  choice_active_down = "<C-j>",
  choice_active_up = "<C-k>",
}

-- comment - 注释
M.comment = {
  toggler = { line = "gcc", block = "gbc" },
  opleader = { line = "gc", block = "gb" },
}

-- ╭──────────────────────────────────────────────────────────╮
-- │  LSP - 语言服务器协议                                     │
-- ╰──────────────────────────────────────────────────────────╯

-- lspsaga - LSP UI增强
M.lspsaga = {
  peek_definition = "gpd",
  peek_implementation = "gpi",
  peek_close = "gpc",
  peek_references = "gpr",
  peek_type = "gpt",
  code_action = "<leader>ca",
  rename = "<leader>rn",
}

-- LSP基础
M.lsp = {
  code_action = "<leader>ca",
  go_definitiion = "gd",
  hover_doc = "gh",
  hover_definition_scroll_up = "su",
  hover_definition_scroll_down = "sd",
  go_declaration = "gD",
  go_implementation = "gi",
  references = "gr",
  line_diagnostics = "gp",
  next_diagnostics = "gj",
  prev_diagnostics = "gk",
  format = "==",
}

-- ╭──────────────────────────────────────────────────────────╮
-- │  Language - 语言特定                                      │
-- ╰──────────────────────────────────────────────────────────╯

-- crates.nvim - Rust crates管理
M.crates = {
  toggle = "<leader>ct",
  reload = "<leader>cr",
  versions = "<leader>cv",
  features = "<leader>cf",
  dependencies = "<leader>cd",
  update = "<leader>cu",
  upgrade = "<leader>cU",
  upgrade_all = "<leader>cA",
  open_homepage = "<leader>cH",
  open_repo = "<leader>cR",
  open_doc = "<leader>cD",
  open_crates_io = "<leader>cC",
}

-- ╭──────────────────────────────────────────────────────────╮
-- │  Git - 版本控制                                           │
-- ╰──────────────────────────────────────────────────────────╯

-- neogit - Git界面
M.neogit = {
  open = "<leader>gg",
}

-- gitsigns - Git标记
M.gitsigns = {
  next_hunk = "<leader>gj",
  prev_hunk = "<leader>gk",
  stage_hunk = "<leader>gs",
  stage_buffer = "<leader>gS",
  undo_stage_hunk = "<leader>gu",
  reset_hunk = "<leader>gr",
  reset_buffer = "<leader>gR",
  preview_hunk = "<leader>gp",
  blame_line = "<leader>gbl",
  diffthis = "<leader>gd",
  diff = "<leader>gD",
  toggle_deleted = "<leader>gtd",
  toggle_current_line_blame = "<leader>gtb",
  select_hunk = "<leader>ig",
}

-- ╭──────────────────────────────────────────────────────────╮
-- │  Tools - 工具                                             │
-- ╰──────────────────────────────────────────────────────────╯

-- conform.nvim - 代码格式化
M.conform = {
  format = "<leader>cf",
}

-- toggleterm - 终端管理
M.toggleTerm = {
  float = "<leader>tf",
  right = "<leader>tr",
  bottom = "<leader>td",
  switch = "<Esc>",
}

return M
