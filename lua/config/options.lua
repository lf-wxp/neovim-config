-- ╭──────────────────────────────────────────────────────────╮
-- │                      Editor Options                       │
-- ╰──────────────────────────────────────────────────────────╯

-- Encoding
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"

-- Scroll margin
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Highlight current line
vim.wo.cursorline = true

-- Sign column
vim.wo.signcolumn = "yes"

-- Color column (line length indicator)
vim.wo.colorcolumn = "100"

-- Indent settings (2 spaces)
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search settings
vim.o.ignorecase = true -- Case insensitive
vim.o.smartcase = true  -- Unless contains uppercase
vim.o.hlsearch = true   -- Highlight search results
vim.o.incsearch = true  -- Incremental search

-- Command line height
vim.o.cmdheight = 2

-- Auto reload externally modified files
vim.opt.autoread = true

-- Disable line wrap
vim.wo.wrap = false

-- Allow cross-line movement
vim.o.whichwrap = "<,>,[,]"

-- Allow hidden modified buffers
vim.o.hidden = true

-- Mouse support
vim.o.mouse = "a"

-- Disable backup files
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- Faster update time
vim.o.updatetime = 300

-- Key sequence timeout
vim.o.timeoutlen = 500

-- Split direction
vim.o.splitbelow = true
vim.o.splitright = true

-- Completion settings
vim.g.completeopt = "menu,menuone,noselect,noinsert"

-- Theme style
vim.o.background = "dark"
vim.o.termguicolors = true

-- Show invisible characters
vim.o.list = true
vim.o.listchars = "space:·,tab:··,leadmultispace:· "

-- Completion menu
vim.o.wildmenu = true
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.pumheight = 10

-- Always show tabline
vim.o.showtabline = 2

-- Disable mode display (using statusline plugin)
vim.o.showmode = false

-- Rust config
vim.g.rust_recommended_style = 0

-- Font
vim.o.guifont = "Maple Mono NF CN"

-- Filetype detection
vim.cmd.filetype("on")
vim.cmd.filetype("plugin on")

-- Format expression
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

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
