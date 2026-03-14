-- ╭────────────────────────────────────────────────────────╮
-- │                   Editor Options                       │
-- ╰────────────────────────────────────────────────────────╯

-- Scroll margin
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Smooth scrolling (Neovim 0.10+, 与 snacks.scroll 动画互补)
-- 确保 <C-d>/<C-u> 滚动时不会跳过屏幕外的换行行
vim.opt.smoothscroll = true

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
-- hlsearch / incsearch 是 Neovim 默认值，无需显式设置

-- Command line height (0: hidden after noice takes over, saves space)
vim.opt.cmdheight = 0

-- Auto reload externally modified files
vim.opt.autoread = true

-- Disable line wrap
vim.opt.wrap = false

-- Allow cross-line movement
vim.opt.whichwrap = "<,>,[,]"

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
vim.o.completeopt = "menu,menuone,noselect,noinsert"

-- Theme style
vim.opt.background = "dark"
vim.opt.termguicolors = true

-- Show invisible characters
vim.opt.list = true
vim.opt.listchars = "space:·,tab:··,leadmultispace:· "

-- Completion menu
-- wildmenu 是 Neovim 默认值，无需显式设置
-- c: 补全消息, I: intro 消息, W: 写入消息, s: 搜索越界消息
vim.opt.shortmess = vim.opt.shortmess + "cIWs"
vim.opt.pumheight = 10
-- Always show tabline
vim.opt.showtabline = 2

-- Disable mode display (using statusline plugin)
vim.opt.showmode = false

-- Rust config
vim.g.rust_recommended_style = 0

-- Font
vim.opt.guifont = "Maple Mono NF CN"

-- Format expression
vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Copilot config (disable default mappings, handled by CodeBuddy)
vim.g.copilot_no_maps = 1

-- Disable unused providers (suppress checkhealth warnings, improve startup)
for _, provider in ipairs({ "perl", "ruby", "node", "python3" }) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

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
