-- ╭──────────────────────────────────────────────────────────╮
-- │                    Keymaps Configuration                  │
-- │        Centralized keymap definitions (pure export)        │
-- ╰──────────────────────────────────────────────────────────╯

-- NOTE: Leader keys are set in init.lua BEFORE lazy.nvim loads
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Export keymap config for plugins
local M = {}

-- ╭──────────────────────────────────────────────────────────╮
-- │         Load Global Keymaps (called by VeryLazy)          │
-- ╰──────────────────────────────────────────────────────────╯

M.load_global = function()
  local km = M.global
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- ╭─────────────────────────────────────────────────────╮
  -- │              Window Management                      │
  -- ╰─────────────────────────────────────────────────────╯
  keymap("n", km.split_vertical, ":vsp<cr>", vim.tbl_extend("force", opts, { desc = "Split Vertical" }))
  keymap("n", km.split_horizontal, ":sp<cr>", vim.tbl_extend("force", opts, { desc = "Split Horizontal" }))
  keymap("n", km.close_window, "<C-w>c", vim.tbl_extend("force", opts, { desc = "Close Window" }))
  keymap("n", km.close_other_windows, "<C-w>o", vim.tbl_extend("force", opts, { desc = "Close Other Windows" }))
  keymap("n", km.equal_windows, "<C-w>=", vim.tbl_extend("force", opts, { desc = "Equal Windows" }))

  -- ╭─────────────────────────────────────────────────────╮
  -- │              Edit Operations                        │
  -- ╰─────────────────────────────────────────────────────╯
  keymap("v", km.move_selection_down, ":move '>+1<cr>gv-gv", vim.tbl_extend("force", opts, { desc = "Move Selection Down" }))
  keymap("v", km.move_selection_up, ":move '<-2<cr>gv-gv", vim.tbl_extend("force", opts, { desc = "Move Selection Up" }))

  -- ╭─────────────────────────────────────────────────────╮
  -- │              Scroll                                 │
  -- ╰─────────────────────────────────────────────────────╯
  keymap("n", km.scroll_up_half, "<Cmd>normal! <C-u>zz<CR>", vim.tbl_extend("force", opts, { desc = "Scroll Up Half Page" }))
  keymap("n", km.scroll_down_half, "<Cmd>normal! <C-d>zz<CR>", vim.tbl_extend("force", opts, { desc = "Scroll Down Half Page" }))
  keymap("n", km.scroll_up_full, "<Cmd>normal! <C-b>zz<CR>", vim.tbl_extend("force", opts, { desc = "Scroll Up Full Page" }))

  -- ╭─────────────────────────────────────────────────────╮
  -- │              Clipboard                              │
  -- ╰─────────────────────────────────────────────────────╯
  keymap({ "n", "v" }, km.paste_from_clipboard, '"+p', vim.tbl_extend("force", opts, { desc = "Paste from Clipboard" }))
  keymap({ "n", "v" }, km.copy_to_clipboard, '"+y', vim.tbl_extend("force", opts, { desc = "Copy to Clipboard" }))

  -- ╭─────────────────────────────────────────────────────╮
  -- │              Search                                 │
  -- ╰─────────────────────────────────────────────────────╯
  keymap("n", km.clear_search, ":noh<cr>", vim.tbl_extend("force", opts, { desc = "Clear Search Highlight" }))

  -- ╭─────────────────────────────────────────────────────╮
  -- │              Navigation History                     │
  -- ╰─────────────────────────────────────────────────────╯
  keymap("n", km.go_back, "<C-o>", vim.tbl_extend("force", opts, { desc = "Go Back" }))
  keymap("n", km.go_forward, "<C-i>", vim.tbl_extend("force", opts, { desc = "Go Forward" }))

  -- ╭─────────────────────────────────────────────────────╮
  -- │              Text Objects                           │
  -- ╰─────────────────────────────────────────────────────╯
  keymap("o", km.inside_bracket, "i[", vim.tbl_extend("force", opts, { desc = "Inside []" }))
  keymap("o", km.around_bracket, "a[", vim.tbl_extend("force", opts, { desc = "Around []" }))
  keymap("o", km.inside_angle, "i<", vim.tbl_extend("force", opts, { desc = "Inside <>" }))
  keymap("o", km.around_angle, "a<", vim.tbl_extend("force", opts, { desc = "Around <>" }))
end

-- ╭──────────────────────────────────────────────────────────╮
-- │  Navigation - File navigation related plugins            │
-- ╰──────────────────────────────────────────────────────────╯

-- nvim-tree - File tree
M.nvimTree = {
  toggle = "<leader>tt",
}

-- oil.nvim - File manager
M.oil = {
  open = "-",
  open_float = "<leader>-",
}

-- telescope - Fuzzy search
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

-- harpoon - Quick file switch
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
  telescope = "<leader>ng",  -- Harpoon telescope
}

-- grug-far - Project search and replace
M.grugFar = {
  project = "<leader>rp",
  file = "<leader>rf",
  word = "<leader>rw",
}

-- ╭──────────────────────────────────────────────────────────╮
-- │  Buffer & UI - Tab/UI related                            │
-- ╰──────────────────────────────────────────────────────────╯

-- bufferline - Tab bar
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

-- snacks.nvim - Dashboard/terminal/buffer management
M.snacks = {
  dashboard = "<leader> ;",
  bufdelete = "<leader>bd",
  bufdelete_other = "<leader>bo",
  terminal = "<c-/>",
}

-- smart-splits - Intelligent window management
M.smartSplits = {
  -- Window navigation
  move_left = "<leader>wh",
  move_down = "<leader>wj",
  move_up = "<leader>wk",
  move_right = "<leader>wl",
  -- Window resize
  resize_left = "<leader>s<",
  resize_right = "<leader>s>",
  resize_down = "<leader>s-",
  resize_up = "<leader>s+",
  -- Equal window sizes (global keymap)
  equal = "<leader>s=",
}

-- window - Basic window management
M.window = {
  split_vertical = "<leader>sv",
  split_horizontal = "<leader>sh",
  close = "<leader>sc",
  close_other = "<leader>so",
}

-- ╭──────────────────────────────────────────────────────────╮
-- │  Editor - Editor enhancement                             │
-- ╰──────────────────────────────────────────────────────────╯

-- flash.nvim - Quick jump
M.flash = {
  jump = "<leader>fj",
  treesitter = "<leader>ft",
}

-- treesj - Code split and join
M.treesj = {
  toggle = "<leader>cj",
}

-- sniprun - Code execution
M.sniprun = {
  run = "<leader>cr",
}

-- yanky - Clipboard history
M.yanky = {
  paste_after = "p",
  paste_before = "P",
  g_paste_after = "gp",
  g_paste_before = "gP",
  cycle_next = "<c-n>",
  cycle_prev = "<c-p>",
  yank_history = "<leader>fy",
}

-- multicursor - Multiple cursors
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

-- luasnip - Code snippets
M.snip = {
  expand_jumpable = "<C-l>",
  jumpable = "<C-h>",
  choice_active_down = "<C-j>",
  choice_active_up = "<C-k>",
}

-- comment - Comment
M.comment = {
  toggler = { line = "gcc", block = "gbc" },
  opleader = { line = "gc", block = "gb" },
}

-- ╭──────────────────────────────────────────────────────────╮
-- │  LSP - Language Server Protocol                          │
-- ╰──────────────────────────────────────────────────────────╯

-- lspsaga - LSP UI enhancement
M.lspsaga = {
  peek_definition = "gpd",
  peek_implementation = "gpi",
  peek_close = "gpc",
  peek_references = "gpr",
  peek_type = "gpt",
  code_action = "<leader>ca",
  rename = "<leader>rn",
}

-- LSP basic
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
-- │  Language - Language specific                            │
-- ╰──────────────────────────────────────────────────────────╯

-- crates.nvim - Rust crates management
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
-- │  Git - Version control                                   │
-- ╰──────────────────────────────────────────────────────────╯

-- neogit - Git interface
M.neogit = {
  open = "<leader>gg",
}

-- gitsigns - Git signs
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
-- │  Tools - Tools                                            │
-- ╰──────────────────────────────────────────────────────────╯

-- conform.nvim - Code formatting
M.conform = {
  format = "<leader>cf",
}

-- ╭──────────────────────────────────────────────────────────╮
-- │  Global - Global vim keymaps (non-plugin)                │
-- ╰──────────────────────────────────────────────────────────╯

-- Window management
M.global = {
  -- Split windows
  split_vertical = "<leader>sv",
  split_horizontal = "<leader>sh",
  close_window = "<leader>sc",
  close_other_windows = "<leader>so",
  equal_windows = "<leader>s=",
  
  -- Move selection in visual mode
  move_selection_down = "J",
  move_selection_up = "K",
  
  -- Scroll
  scroll_up_half = "<leader>u",
  scroll_down_half = "<leader>d",
  scroll_up_full = "<leader>b",
  
  -- Clipboard
  paste_from_clipboard = "<leader>p",
  copy_to_clipboard = "<leader>y",
  
  -- Search
  clear_search = "<leader>k",
  
  -- Navigation history
  go_back = "<leader>o",
  go_forward = "<leader>i",
  
  -- Text object aliases
  inside_bracket = "ir",
  around_bracket = "ar",
  inside_angle = "ia",
  around_angle = "aa",
}

return M
