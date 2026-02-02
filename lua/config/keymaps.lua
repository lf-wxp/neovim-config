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

-- Window Navigation
map("n", "<leader>wh", "<C-w>h", "Go Left Window")
map("n", "<leader>wj", "<C-w>j", "Go Down Window")
map("n", "<leader>wk", "<C-w>k", "Go Up Window")
map("n", "<leader>wl", "<C-w>l", "Go Right Window")

-- Window Resize
map("n", "<leader>shh", ":vertical resize -10<cr>", "Window Width -10")
map("n", "<leader>sll", ":vertical resize +10<cr>", "Window Width +10")
map("n", "<leader>sjj", ":resize +10<cr>", "Window Height +10")
map("n", "<leader>skk", ":resize -10<cr>", "Window Height -10")
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

-- multicursor
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

-- LSP
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

-- luasnip
M.snip = {
  expand_jumpable = "<C-l>",
  jumpable = "<C-h>",
  choice_active_down = "<C-j>",
  choice_active_up = "<C-k>",
}

-- comment
M.comment = {
  toggler = { line = "gcc", block = "gbc" },
  opleader = { line = "gc", block = "gb" },
}

-- toggleterm
M.toggleTerm = {
  float = "<leader>tf",
  right = "<leader>tr",
  bottom = "<leader>td",
  switch = "<Esc>",
}

-- gitsigns
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

-- harpoon
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

return M
