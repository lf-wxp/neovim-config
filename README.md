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

All keymaps are centralized in `lua/config/keymaps.lua` for easy management.

### General

| Key | Description |
|-----|-------------|
| `<leader>k` | Clear search highlight |
| `<leader>y` | Copy to system clipboard |
| `<leader>p` | Paste from clipboard |
| `<leader>u` | Scroll up half page |
| `<leader>d` | Scroll down half page |
| `<leader>b` | Scroll up full page |
| `<leader>o` | Go back |
| `<leader>i` | Go forward |

### Window Management

| Key | Description |
|-----|-------------|
| `<leader>sv` | Split vertical |
| `<leader>sh` | Split horizontal |
| `<leader>sc` | Close window |
| `<leader>so` | Close other windows |
| `<leader>s=` | Equal window sizes |
| `<leader>wh/j/k/l` | Navigate windows (smart-splits) |
| `<leader>s</>` | Resize window width |
| `<leader>s-/+` | Resize window height |

### File Navigation

| Key | Description |
|-----|-------------|
| `<leader>tt` | Toggle file tree (nvim-tree) |
| `-` | Open parent directory (oil) |
| `<leader>-` | Open oil in float |
| `<leader>ff` | Find files (telescope) |
| `<leader>fg` | Live grep (telescope) |
| `<leader>fp` | Projects (telescope) |
| `<leader>fc` | Colorschemes (telescope) |
| `<leader>fe` | File browser (telescope) |
| `<leader>fk` | Keymaps (telescope) |
| `<leader>fb` | Buffers (telescope) |
| `<Tab>` | Buffers (telescope) |

### Tabs/Buffers

| Key | Description |
|-----|-------------|
| `<leader>h` | Previous tab |
| `<leader>l` | Next tab |
| `<leader><` | Move tab left |
| `<leader>>` | Move tab right |
| `<leader>tp` | Pick tab |
| `<leader>tc` | Close current tab |
| `<leader>bcl` | Close tabs to the right |
| `<leader>bch` | Close tabs to the left |
| `<leader>bc` | Pick and close tab |
| `<leader>bd` | Delete buffer (snacks) |
| `<leader>bo` | Delete other buffers (snacks) |

### LSP & Code Actions

| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `gh` | Hover documentation |
| `gD` | Go to declaration |
| `gi` | Find implementations |
| `gr` | Find references |
| `gp` | Line diagnostics |
| `gj` | Next diagnostic |
| `gk` | Previous diagnostic |
| `==` | Format code |
| `gpd` | Peek definition (lspsaga) |
| `gpi` | Peek implementation (lspsaga) |
| `gpr` | Peek references (lspsaga) |
| `gpt` | Peek type definition (lspsaga) |
| `gpc` | Close peek (lspsaga) |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>cf` | Format with conform |

### Git

| Key | Description |
|-----|-------------|
| `<leader>gg` | Open Neogit |
| `<leader>gj` | Next hunk |
| `<leader>gk` | Previous hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gS` | Stage buffer |
| `<leader>gu` | Undo stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gR` | Reset buffer |
| `<leader>gp` | Preview hunk |
| `<leader>gbl` | Blame line |
| `<leader>gd` | Diff this |
| `<leader>gD` | Diff all |
| `<leader>gtd` | Toggle deleted |
| `<leader>gtb` | Toggle line blame |
| `<leader>ig` | Select hunk (text object) |

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
| `<leader>rp` | Project search & replace (grug-far) |
| `<leader>rf` | Find in files (grug-far) |
| `<leader>rw` | Replace word (grug-far) |

### Terminal

| Key | Description |
|-----|-------------|
| `<leader>tf` | Float terminal |
| `<leader>tr` | Right terminal |
| `<leader>td` | Bottom terminal |
| `<leader> ;` | Dashboard (snacks) |
| `<C-/>` | Toggle terminal (snacks) |

### Editor Enhancements

| Key | Description |
|-----|-------------|
| `<leader>fj` | Flash jump (character) |
| `<leader>ft` | Flash treesitter |
| `<leader>cj` | Toggle split/join code blocks |
| `<leader>cr` | Run code snippet (sniprun) |
| `gcc` | Toggle line comment |
| `gbc` | Toggle block comment |

### Yanky (Clipboard Ring)

| Key | Description |
|-----|-------------|
| `p` / `P` | Paste after/before (with history) |
| `gp` / `gP` | Paste & move after/before |
| `<C-n>` / `<C-p>` | Cycle clipboard history |
| `<leader>fy` | Open yank history picker |

### Multi-cursor

| Key | Description |
|-----|-------------|
| `<Up>/<Down>` | Add cursor above/below |
| `<leader><Up>/<Down>` | Skip cursor above/below |
| `<leader>m` | Add next match |
| `<leader>M` | Add previous match |
| `<leader>s` | Skip next match |
| `<leader>S` | Skip previous match |
| `<C-q>` | Toggle cursor |
| `<Left>/<Right>` | Prev/Next cursor |
| `<leader>x` | Delete cursor |
| `<C-LeftMouse>` | Add cursor with mouse |

### Crates (Rust)

| Key | Description |
|-----|-------------|
| `<leader>ct` | Toggle crates popup |
| `<leader>cr` | Reload crates |
| `<leader>cv` | Show versions |
| `<leader>cf` | Show features |
| `<leader>cd` | Show dependencies |
| `<leader>cu` | Update crate |
| `<leader>cU` | Upgrade crate |
| `<leader>cA` | Upgrade all crates |
| `<leader>cH` | Open homepage |
| `<leader>cR` | Open repository |
| `<leader>cD` | Open documentation |
| `<leader>cC` | Open crates.io |

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
- **highlight-undo.nvim** - Visual feedback for undo/redo |- **nvim-ts-autotag** - Auto-close/rename HTML tags

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
