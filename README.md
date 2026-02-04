# 🚀 Neovim Configuration

A modern, fast, and feature-rich Neovim configuration built with Lua. Optimized for frontend development (TypeScript, Vue, React) and Rust.

## ✨ Features

- 🎨 Beautiful UI with **Zephyr** colorscheme (custom highlights)
- ⚡ Fast startup with **lazy.nvim** plugin manager
- 🔧 Full LSP support with intelligent auto-completion (20+ sources)
- 🌲 Treesitter-based syntax highlighting and analysis
- 🔍 Fuzzy finding with **Telescope** and project search/replace with **Grug-Far**
- 📁 File explorer with **nvim-tree** and **oil.nvim** (buffer-style)
- 🔀 Complete Git workflow with **gitsigns**, **neogit** and **diffview**
- ✏️ Modern editing features (multi-cursor, surround, autopairs, flash jump, clipboard ring with picker)
- 💻 Terminal integration with **toggleterm** (float/right/bottom)
- 📊 Beautiful statusline with **lualine** and **bufferline**
- 🎯 Quick file navigation with **harpoon** and **auto-session**
- � Intelligent window management with **smart-splits.nvim**
- �🤖 AI code assistance with **codecompanion** and **CodeBuddy**
- 🦀 Rust development tools with **rustaceanvim**, **crates.nvim**, **krust**
- 🎨 Tailwind CSS enhanced experience
- 🔧 Auto formatting with **conform.nvim** and **none-ls.nvim**
- 📑 Markdown rendering with **markview.nvim**
- 🔄 Session management (auto-save/restore)
- 💡 Symbol usage and context information

## 📦 Requirements

- Neovim >= 0.10.0
- Git
- Node.js (for LSP servers)
- A [Nerd Font](https://www.nerdfonts.com/) (recommended: Maple Mono NF CN)
- ripgrep (for Telescope live grep)

## 🛠️ Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this repository
git clone https://github.com/yourusername/nvim ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

## 📂 Project Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/              # Core configuration
│   │   ├── options.lua      # Vim options
│   │   ├── keymaps.lua      # Key mappings
│   │   ├── autocmds.lua     # Auto commands
│   │   ├── lazy.lua         # Plugin manager setup
│   │   └── neovide.lua      # Neovide GUI settings
│   ├── plugins/             # Plugin specifications
│   │   ├── ui.lua           # UI components
│   │   ├── editor.lua       # Editor enhancements
│   │   ├── navigation.lua   # Navigation plugins
│   │   ├── coding.lua       # Completion & snippets
│   │   ├── lsp.lua          # LSP configuration
│   │   ├── git.lua          # Git integration
│   │   ├── formatting.lua   # Formatters & linters
│   │   ├── lang.lua         # Language specific
│   │   ├── tools.lua        # Terminal & utilities
│   │   └── colorscheme.lua  # Themes
│   ├── plugin-config/       # Detailed plugin configs
│   ├── lsp/                 # LSP configurations
│   │   ├── setup.lua        # LSP setup
│   │   ├── common.lua       # Common LSP config
│   │   └── config/          # Per-language LSP configs
│   └── cmp/                 # Completion configuration
```

## ⌨️ Key Mappings

Leader key: `<Space>`

### General

| Key | Description |
|-----|-------------|
| `<leader>k` | Clear search highlight |
| `<leader>y` | Copy to system clipboard |
| `<leader>p` | Open yank history picker |
| `<leader>u` | Scroll up half page |
| `<leader>d` | Scroll down half page |
| `<leader>o` | Go back |
| `<leader>i` | Go forward |

### Window Management

| Key | Description |
|-----|-------------|
| `<leader>sv` | Split vertical |
| `<leader>sh` | Split horizontal |
| `<leader>sc` | Close window |
| `<leader>so` | Close other windows |
| `<leader>wh/j/k/l` | Navigate windows |
| `<leader>s=` | Equal window sizes |

### File Navigation

| Key | Description |
|-----|-------------|
| `<leader>tt` | Toggle file tree |
| `<leader><leader>f` | Find files |
| `<leader><leader>t` | Live grep |
| `<leader><leader>b` | List buffers |
| `<Tab>` | List buffers |
| `-` | Open parent directory (Oil) |

### Tabs/Buffers

| Key | Description |
|-----|-------------|
| `<leader>h` | Previous tab |
| `<leader>l` | Next tab |
| `<leader>tc` | Close current tab |
| `<leader>tp` | Pick tab |

### LSP

| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `gh` | Hover documentation |
| `gi` | Find implementations |
| `gr` | Find references |
| `gp` | Line diagnostics |
| `gj` | Next diagnostic |
| `gk` | Previous diagnostic |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `==` | Format code |

### Git

| Key | Description |
|-----|-------------|
| `<leader>gg` | Open Neogit |
| `<leader>gj` | Next hunk |
| `<leader>gk` | Previous hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gp` | Preview hunk |
| `<leader>gbl` | Blame line |
| `<leader>gd` | Diff this |
| `:Trouble` | Open diagnostics list |

### Harpoon (Quick Files)

| Key | Description |
|-----|-------------|
| `<leader>na` | Add file to harpoon |
| `<leader>nt` | Toggle harpoon menu |
| `<leader>nn` | Next harpoon file |
| `<leader>np` | Previous harpoon file |
| `<leader>n1-6` | Jump to file 1-6 |

### Project Search & Replace

| Key | Description |
|-----|-------------|
| `<leader><leader>p` | Open project |
| `<leader>rp` | Project search & replace |
| `<leader>rf` | Find in files |
| `<leader>rw` | Replace in files |

### Terminal

| Key | Description |
|-----|-------------|
| `<leader>tf` | Float terminal |
| `<leader>tr` | Right terminal |
| `<leader>td` | Bottom terminal |
| `<leader>;` | Dashboard |
| `<C-/>` | Toggle terminal |

### Editor

| Key | Description |
|-----|-------------|
| `<leader>f` | Flash jump (character) |
| `<leader>F` | Flash jump (line) |
| `<leader>e` | Toggle split/join code blocks |
| `<leader>R` | Run code snippet |
| `<leader>ssr` | Structured search replace |
| `gcc` | Toggle line comment |
| `gbc` | Toggle block comment |
| `<leader>bd` | Close buffer with snacks |
| `<leader>p` | Open yank history picker |
| `p` / `P` | Paste from clipboard history (yanky) |
| `<C-n>` / `<C-p>` | Cycle clipboard history |

### Multi-cursor

| Key | Description |
|-----|-------------|
| `<Up>/<Down>` | Add cursor above/below |
| `<leader>m` | Add next match |
| `<C-q>` | Toggle cursor |
| `<C-LeftMouse>` | Add cursor with mouse |

## 🔌 Plugin List

### UI
- **bufferline.nvim** - Tab bar with buffer management
- **lualine.nvim** - Status line with custom components
- **noice.nvim** - UI for messages, cmdline, and popupmenu
- **which-key.nvim** - Keymap hints with icons
- **snacks.nvim** - Dashboard, notifications, terminal, indent guides
- **dropbar.nvim** - Breadcrumb navigation (winbar)
- **tiny-glimmer.nvim** - Cursor movement effects
- **reactive.nvim** - Mode-based cursor styling
- **helpview.nvim** - Help file rendering
- **markview.nvim** - Markdown rendering
- **nvim-highlight-colors** - Highlight color codes
- **log-highlight.nvim** - Log file highlighting
- **cellular-automaton.nvim** - Fun pixel animations

### Editor
- **flash.nvim** - Quick navigation (character/line jump)
- **yanky.nvim** - Clipboard ring history with picker and navigation
- **nvim-surround** - Add/delete/change surrounding characters
- **surround-ui.nvim** - Visual interface for surround
- **nvim-autopairs** - Auto-close brackets, quotes, etc.
- **multicursor.nvim** - Multi-cursor editing
- **ts-comments.nvim** - Better comment support with treesitter
- **mini.ai** - Enhanced text objects
- **treesj** - Split/join code blocks
- **nvim-origami** - Smart code folding (auto save/restore)
- **nvim-recorder** - Macro recording enhancement
- **coerce.nvim** - Case conversion utilities
- **marks.nvim** - Visualized marks
- **atone.nvim** - Undo history viewer and recovery
- **sniprun** - Run code snippets
- **nvim_context_vt** - Show code block context
- **hlargs.nvim** - Highlight function arguments
- **ssr.nvim** - Structured search replace
- **highlight-undo.nvim** - Visual feedback for undo/redo
- **nvim-ts-autotag** - Auto-close/rename HTML tags

### Navigation
- **nvim-tree.lua** - File explorer
- **oil.nvim** - Buffer-style file manager
- **telescope.nvim** - Fuzzy finder (files, grep, projects, etc.)
- **project.nvim** - Project management and switching
- **harpoon** - Quick file switching
- **grug-far.nvim** - Project search and replace
- **nvim-navbuddy** - Symbol navigation
- **auto-session** - Auto save/restore sessions
- **store.nvim** - Note storage

### LSP & Completion
- **nvim-lspconfig** - LSP configuration
- **mason.nvim** - LSP/DAP/Linter manager
- **mason-lspconfig.nvim** - Mason & LSP bridge
- **lspsaga.nvim** - LSP UI enhancement
- **symbol-usage.nvim** - Show symbol usage counts
- **lazydev.nvim** - Lua development enhancement
- **schemastore.nvim** - JSON/YAML schema support
- **nvim-cmp** - Completion engine
- **LuaSnip** - Snippet engine
- **friendly-snippets** - Predefined snippets collection
- **lspkind-nvim** - Icons for completion items
- **cmp-nvim-lsp** - LSP completion source
- **cmp-buffer** - Buffer word completion
- **cmp-path** - File path completion
- **cmp-cmdline** - Command-line completion
- **cmp-nvim-lua** - Neovim Lua API completion
- **cmp-calc** - Math calculation completion
- **cmp-emoji** - Emoji completion
- **cmp-nvim-lsp-signature-help** - Function signature help
- **cmp-nvim-lsp-document-symbol** - Document symbol completion
- **cmp-treesitter** - Treesitter-aware completion
- **cmp-npm** - NPM package completion
- **nvim-html-css** - HTML/CSS id/class completion
- **cmp-git** - Git commit/branch completion
- **cmp-rg** - Ripgrep search completion
- **cmp-dictionary** - Dictionary completion
- **cmp-async-path** - Async path completion
- **cmp_yanky** - Clipboard history completion
- **cmp-under-comparator** - Sorting optimization for underscore prefixes
- **nvim-treesitter** - Syntax highlighting and analysis
- **conform.nvim** - Code formatter
- **none-ls.nvim** - Linting and code actions
- **mason-null-ls.nvim** - Auto install formatting/linting tools

### Git
- **gitsigns.nvim** - Git signs in gutter
- **neogit** - Git interface
- **diffview.nvim** - Diff viewer

### Language Support
- **nvim-treesitter** - Syntax highlighting
- **rustaceanvim** - Rust tools (RA integration)
- **crates.nvim** - Cargo.toml dependency management
- **krust.nvim** - Rust test runner
- **tailwind-tools.nvim** - Tailwind CSS enhancement
- **codecompanion.nvim** - AI code assistant
- **CodeBuddy** - Internal AI copilot

## 🎨 Colorschemes

Default: **Zephyr** (with custom highlights for Telescope, multi-cursor, Symbol Usage, Dropbar, window separators)

Alternative schemes available:
- Gruvbox
- Kanagawa
- Catppuccin

Custom highlights configured for:
- Telescope selections
- Multi-cursor
- Symbol usage indicators
- Dropbar components
- Window separator lines

Switch colorscheme in `~/.config/nvim/lua/plugins/colorscheme.lua`

## 📝 License

MIT License

## 🙏 Acknowledgements

Inspired by:
- [LazyVim](https://github.com/LazyVim/LazyVim)
- [NvChad](https://github.com/NvChad/NvChad)
- [AstroNvim](https://github.com/AstroNvim/AstroNvim)
