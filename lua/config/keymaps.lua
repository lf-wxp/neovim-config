-- ╭────────────────────────────────────────────────────────╮
-- │               Keymaps Configuration                    │
-- │      Centralized keymap definitions (pure export)      │
-- ╰────────────────────────────────────────────────────────╯

-- Export keymap config for plugins
local M = {}

-- ╭────────────────────────────────────────────────────────╮
-- │      Load Global Keymaps (called by VeryLazy)          │
-- ╰────────────────────────────────────────────────────────╯

M.load_global = function()
  local km = M.global
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  --- Helper: set keymap with desc merged into opts
  local function map(mode, lhs, rhs, desc)
    keymap(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
  end

  -- ╭─────────────────────────────────────────────────────╮
  -- │              Window Management                      │
  -- ╰─────────────────────────────────────────────────────╯
  map("n", km.split_vertical, ":vsp<cr>", "Split Vertical")
  map("n", km.split_horizontal, ":sp<cr>", "Split Horizontal")
  map("n", km.close_window, "<C-w>c", "Close Window")
  map("n", km.close_other_windows, "<C-w>o", "Close Other Windows")
  map("n", km.equal_windows, "<C-w>=", "Equal Windows")

  -- ╭─────────────────────────────────────────────────────╮
  -- │              Edit Operations                        │
  -- ╰─────────────────────────────────────────────────────╯
  map("v", km.move_selection_down, ":move '>+1<cr>gv-gv", "Move Selection Down")
  map("v", km.move_selection_up, ":move '<-2<cr>gv-gv", "Move Selection Up")

  -- ╭─────────────────────────────────────────────────────╮
  -- │              Scroll                                 │
  -- ╰─────────────────────────────────────────────────────╯
  map("n", km.scroll_up_half, "<C-u>", "Scroll Up Half Page")
  map("n", km.scroll_down_half, "<C-d>", "Scroll Down Half Page")
  map("n", km.scroll_up_full, "<C-b>", "Scroll Up Full Page")

  -- ╭─────────────────────────────────────────────────────╮
  -- │              Clipboard                              │
  -- ╰─────────────────────────────────────────────────────╯
  map({ "n", "v" }, km.paste_from_clipboard, '"+p', "Paste from Clipboard")
  map({ "n", "v" }, km.copy_to_clipboard, '"+y', "Copy to Clipboard")

  -- ╭─────────────────────────────────────────────────────╮
  -- │              Search                                 │
  -- ╰─────────────────────────────────────────────────────╯
  map("n", km.clear_search, ":noh<cr>", "Clear Search Highlight")

  -- ╭─────────────────────────────────────────────────────╮
  -- │              Navigation History                     │
  -- ╰─────────────────────────────────────────────────────╯
  map("n", km.go_back, "<C-o>", "Go Back")
  map("n", km.go_forward, "<C-i>", "Go Forward")

  -- ╭─────────────────────────────────────────────────────╮
  -- │              Text Objects                           │
  -- ╰─────────────────────────────────────────────────────╯
  map("o", km.inside_bracket, "i[", "Inside []")
  map("o", km.around_bracket, "a[", "Around []")
  map("o", km.inside_angle, "i<", "Inside <>")
  map("o", km.around_angle, "a<", "Around <>")
end

-- ╭────────────────────────────────────────────────────────╮
-- │  Navigation - File navigation related plugins          │
-- ╰────────────────────────────────────────────────────────╯

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

-- trouble - Diagnostics list
M.trouble = {
  toggle = "<leader>xx",
  diagnostics = "<leader>xd",
  symbols = "<leader>xs",
  lsp_references = "<leader>xr",
  loclist = "<leader>xl",
  quickfix = "<leader>xq",
}

-- nvim-navbuddy -> aerial.nvim - Symbol navigation
M.aerial = {
  nav_toggle = "<leader>nb", -- Float breadcrumb navigation (like navbuddy)
  toggle = "<leader>no",     -- Symbol outline sidebar
}

-- ╭────────────────────────────────────────────────────────╮
-- │  Buffer & UI - Tab/UI related                          │
-- ╰────────────────────────────────────────────────────────╯

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
  dashboard = "<leader>;",
  bufdelete = "<leader>bd",
  bufdelete_other = "<leader>bo",
  terminal = "<c-/>",
  terminal_float = "<leader>tf",
  terminal_right = "<leader>tr",
  terminal_bottom = "<leader>td",
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
}

-- ╭────────────────────────────────────────────────────────╮
-- │  Editor - Editor enhancement                           │
-- ╰────────────────────────────────────────────────────────╯

-- flash.nvim - Quick jump
M.flash = {
  jump = "<leader>fj",
  treesitter = "<leader>fS",
}

-- treesj - Code split and join
M.treesj = {
  toggle = "<leader>cj",
}

-- sniprun - Code execution
M.sniprun = {
  run = "<leader>cs",
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
  skipNextMatch = "<leader>ms",
  skipPrevMatch = "<leader>mS",
  addCursorWithMouse = "<c-leftmouse>",
  toggleCursor = "<c-q>",
  prevCursor = "<left>",
  nextCursor = "<right>",
  deleteCursor = "<leader>mx",
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

-- todo-comments - TODO Comment Highlight & Navigation
M.todoComments = {
  next = "]t",
  prev = "[t",
  search = "<leader>ft",
  search_fixme = "<leader>fT",
}

-- ╭────────────────────────────────────────────────────────╮
-- │  LSP - Language Server Protocol                        │
-- ╰────────────────────────────────────────────────────────╯

-- lspsaga - LSP UI enhancement
M.lspsaga = {
  peek_definition = "gpd",
  peek_implementation = "gpi",
  peek_references = "gpr",
  peek_type = "gpt",
  code_action = "<leader>ca",
  rename = "<leader>rn",
  hover_scroll_up = "su",
  hover_scroll_down = "sd",
}

-- LSP basic (code_action handled by lspsaga)
M.lsp = {
  go_definition = "gd",
  hover_doc = "gh",
  go_declaration = "gD",
  go_implementation = "gi",
  type_definition = "gy",
  signature_help = "gs",
  line_diagnostics = "gl",
  next_diagnostics = "gj",
  prev_diagnostics = "gk",
  document_symbols = "<leader>gds",
  workspace_symbols = "<leader>ws",
  toggle_inlay_hints = "<leader>gh",
  codelens_run = "<leader>cl",
  format = "==",
}

-- ╭────────────────────────────────────────────────────────╮
-- │  Language - Language specific                          │
-- ╰────────────────────────────────────────────────────────╯

-- CodeBuddy - AI Copilot
M.codeBuddy = {
  copilot_accept = "<Right>",
}

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

-- ╭────────────────────────────────────────────────────────╮
-- │  Git - Version control                                 │
-- ╰────────────────────────────────────────────────────────╯

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

-- ╭────────────────────────────────────────────────────────╮
-- │  Tools - Tools                                         │
-- ╰────────────────────────────────────────────────────────╯

-- treesitter-textobjects - Swap parameters
M.treesitterSwap = {
  swap_next = "<leader>a",
  swap_prev = "<leader>A",
}

-- ccc.nvim - Color picker (highlighter 功能由 nvim-highlight-colors 统一处理)
M.ccc = {
  pick = "<leader>cp",
  convert = "<leader>coc",
}

-- ╭────────────────────────────────────────────────────────╮
-- │  Global - Global vim keymaps (non-plugin)              │
-- ╰────────────────────────────────────────────────────────╯

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
