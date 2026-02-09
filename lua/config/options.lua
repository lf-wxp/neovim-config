-- ╭────────────────────────────────────────────────────────╮
-- │                   Editor Options                       │
-- ╰────────────────────────────────────────────────────────╯

-- Encoding
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"

-- Scroll margin
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight current line
vim.opt.cursorline = true

-- Sign column
vim.opt.signcolumn = "yes"

-- Color column (line length indicator)
vim.opt.colorcolumn = "100"

-- Indent settings (2 spaces)
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search settings
vim.opt.ignorecase = true -- Case insensitive
vim.opt.smartcase = true  -- Unless contains uppercase
vim.opt.hlsearch = true   -- Highlight search results
vim.opt.incsearch = true  -- Incremental search

-- Command line height (0: hidden after noice takes over, saves space)
vim.opt.cmdheight = 0

-- Auto reload externally modified files
vim.opt.autoread = true

-- Disable line wrap
vim.opt.wrap = false

-- Allow cross-line movement
vim.opt.whichwrap = "<,>,[,]"

-- Allow hidden modified buffers
vim.opt.hidden = true

-- Mouse support
vim.opt.mouse = "a"

-- Disable backup files
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Persistent undo (survive file close/reopen)
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.undolevels = 10000

-- Faster update time
vim.opt.updatetime = 300

-- Key sequence timeout
vim.opt.timeoutlen = 500

-- Split direction
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Completion settings
vim.g.completeopt = "menu,menuone,noselect,noinsert"

-- Theme style
vim.opt.background = "dark"
vim.opt.termguicolors = true

-- Show invisible characters
vim.opt.list = true
vim.opt.listchars = "space:·,tab:··,leadmultispace:· "

-- Completion menu
vim.opt.wildmenu = true
vim.opt.shortmess = vim.opt.shortmess + "c"
vim.opt.pumheight = 10
-- Always show tabline
vim.opt.showtabline = 2

-- Disable mode display (using statusline plugin)
vim.opt.showmode = false

-- Rust config
vim.g.rust_recommended_style = 0

-- Font
vim.opt.guifont = "Maple Mono NF CN"

-- Filetype detection
vim.cmd.filetype("on")
vim.cmd.filetype("plugin on")

-- Format expression
vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Copilot config
vim.g.copilot_no_maps = 1

-- Disable unused providers (suppress checkhealth warnings)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

-- Window separator characters - hidden for clean look
vim.opt.fillchars = {
  eob = " ", -- Hide ~ at end of buffer
  vert = " ", -- Hide vertical split lines (use space)
  horiz = " ", -- Hide horizontal split lines (use space)
  horizup = " ",
  horizdown = " ",
  vertright = " ",
  vertleft = " ",
  verthoriz = " ",
}

-- Global floating window borderless (Neovim 0.11+)
vim.o.winborder = "none"
