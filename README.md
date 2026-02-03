# 🚀 Neovim Configuration

A modern, fast, and feature-rich Neovim configuration built with Lua. Optimized for frontend development (TypeScript, Vue, React) and Rust.

## ✨ Features

- 🎨 Beautiful UI with **Catppuccin** colorscheme
- ⚡ Fast startup with **lazy.nvim** plugin manager
- 🔧 Full LSP support with auto-completion
- 🌲 Treesitter-based syntax highlighting
- 🔍 Fuzzy finding with **Telescope**
- 📁 File explorer with **nvim-tree** and **oil.nvim**
- 🔀 Git integration with **gitsigns** and **neogit**
- ✏️ Modern editing features (multi-cursor, surround, autopairs)
- 💻 Terminal integration with **toggleterm**
- 📊 Beautiful statusline with **lualine**
- 🎯 Quick file navigation with **harpoon**

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
| `<leader>p` | Paste from system clipboard |
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

### Harpoon (Quick Files)

| Key | Description |
|-----|-------------|
| `<leader>na` | Add file to harpoon |
| `<leader>nt` | Toggle harpoon menu |
| `<leader>nn` | Next harpoon file |
| `<leader>np` | Previous harpoon file |
| `<leader>n1-6` | Jump to file 1-6 |

### Terminal

| Key | Description |
|-----|-------------|
| `<leader>tf` | Float terminal |
| `<leader>tr` | Right terminal |
| `<leader>td` | Bottom terminal |
| `<C-/>` | Toggle terminal |

### Editor

| Key | Description |
|-----|-------------|
| `<leader>f` | Flash jump |
| `<leader>e` | Toggle split/join |
| `<leader>R` | Run code snippet |
| `gcc` | Toggle line comment |
| `gbc` | Toggle block comment |

### Multi-cursor

| Key | Description |
|-----|-------------|
| `<Up>/<Down>` | Add cursor above/below |
| `<leader>m` | Add next match |
| `<C-q>` | Toggle cursor |
| `<C-LeftMouse>` | Add cursor with mouse |

## 🔌 Plugin List

### UI
- **bufferline.nvim** - Tab bar
- **lualine.nvim** - Status line
- **noice.nvim** - UI for messages, cmdline
- **which-key.nvim** - Keymap hints
- **snacks.nvim** - Dashboard, notifications, indent guides & more
- **dropbar.nvim** - Breadcrumb navigation

### Editor
- **flash.nvim** - Quick navigation
- **nvim-surround** - Surround text objects
- **nvim-autopairs** - Auto pairs
- **multicursor.nvim** - Multi-cursor editing
- **ts-comments.nvim** - Better comments
- **treesj** - Split/join code blocks

### Navigation
- **nvim-tree.lua** - File explorer
- **oil.nvim** - Buffer-style file manager
- **telescope.nvim** - Fuzzy finder
- **harpoon** - Quick file switching
- **grug-far.nvim** - Project search & replace

### LSP & Completion
- **nvim-lspconfig** - LSP configuration
- **mason.nvim** - LSP/DAP/Linter manager
- **lspsaga.nvim** - LSP UI enhancement
- **nvim-cmp** - Completion engine
- **LuaSnip** - Snippet engine
- **conform.nvim** - Formatter

### Git
- **gitsigns.nvim** - Git signs in gutter
- **neogit** - Git interface
- **diffview.nvim** - Diff viewer

### Language Support
- **nvim-treesitter** - Syntax highlighting
- **rustaceanvim** - Rust tools
- **tailwind-tools.nvim** - Tailwind CSS

## 🎨 Colorschemes

Default: **Catppuccin Mocha**

Alternative schemes available:
- Gruvbox
- Kanagawa
- GitHub
- VSCode
- Nightfox
- One Dark

Switch colorscheme: `<leader><leader>c`

## 📝 License

MIT License

## 🙏 Acknowledgements

Inspired by:
- [LazyVim](https://github.com/LazyVim/LazyVim)
- [NvChad](https://github.com/NvChad/NvChad)
- [AstroNvim](https://github.com/AstroNvim/AstroNvim)
