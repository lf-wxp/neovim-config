# Neovim Configuration

A modular, performance-optimized Lua-based Neovim IDE configuration built on **lazy.nvim** with 75+ plugins.

## ✨ Features

- **75+ Plugins** organized into 9 functional categories
- **Lazy Loading** via lazy.nvim for optimal startup performance (~30ms)
- **Unified Module Pattern** — all configs follow the `M.setup()` convention
- **LSP Support** for JavaScript/TypeScript, Rust, Lua, Python, Vue, CSS, HTML, JSON, TOML
- **Modern Completion** powered by blink.cmp (replaces nvim-cmp)
- **Minimal UI** with borderless floating windows and clean aesthetics
- **Git Integration** via Gitsigns, Neogit, and Diffview
- **Smart Navigation** with Telescope, Harpoon, Oil.nvim, Flash, and Aerial
- **AI Coding** with Copilot and CodeCompanion
- **Smart Formatting** with oxfmt / prettierd auto-detection
- **Centralized Keymaps** — all bindings defined in `keymaps.lua`, no hardcoding in plugins

## 📁 Project Structure

```
~/.config/nvim/
├── init.lua                          # Entry point
├── lua/
│   ├── config/                       # Core configuration
│   │   ├── autocmds.lua              # Autocommands
│   │   ├── commands.lua              # User commands (plugin API wrappers)
│   │   ├── keymap-validator.lua      # Keymap conflict detection
│   │   ├── keymaps.lua               # All keybindings (centralized)
│   │   ├── lazy.lua                  # lazy.nvim bootstrap
│   │   ├── neovide.lua               # Neovide GUI config
│   │   ├── options.lua               # Vim options
│   │   └── utils.lua                 # Utility functions
│   │
│   ├── plugins/                      # Plugin specs (lazy.nvim declarations)
│   │   ├── coding.lua                # Completion, snippets, brackets
│   │   ├── colorscheme.lua           # Theme and highlight overrides
│   │   ├── editor.lua                # Editor enhancements
│   │   ├── formatting.lua            # Formatters and linters
│   │   ├── git.lua                   # Git integration
│   │   ├── lang.lua                  # Language-specific plugins
│   │   ├── lsp.lua                   # LSP core plugins
│   │   ├── navigation.lua            # File navigation and search
│   │   └── ui.lua                    # UI components
│   │
│   ├── plugin-config/                # Plugin implementations (M.setup() modules)
│   │   ├── auto-session.lua          # Session management
│   │   ├── bufferline.lua            # Tab bar
│   │   ├── codecompanion.lua         # AI coding assistant
│   │   ├── diffview.lua              # Git diff viewer
│   │   ├── dropbar.lua               # Breadcrumb navigation
│   │   ├── flash.lua                 # Quick motion
│   │   ├── gitsigns.lua              # Git signs in gutter
│   │   ├── harpoon.lua               # Quick file navigation
│   │   ├── lspsaga.lua               # LSP UI enhancement
│   │   ├── lualine.lua               # Status line
│   │   ├── luasnip.lua               # Snippet engine
│   │   ├── multicursor.lua           # Multiple cursors
│   │   ├── noice.lua                 # Cmdline/notify UI
│   │   ├── nvim-autopairs.lua        # Auto bracket pairing
│   │   ├── nvim-tree.lua             # File tree
│   │   ├── nvim-treesitter.lua       # Syntax highlighting
│   │   ├── oil.lua                   # File explorer (buffer-based)
│   │   ├── origami.lua               # Folding
│   │   ├── project.lua               # Project detection
│   │   ├── reactive.lua              # Mode cursor styling
│   │   ├── smart-splits.lua          # Window management
│   │   ├── snacks.lua                # Dashboard, terminal, utilities
│   │   ├── symbol-usage.lua          # Symbol reference counts
│   │   ├── telescope.lua             # Fuzzy finder
│   │   ├── tiny-glimmer.lua          # Yank highlight animation
│   │   ├── which-key.lua             # Keymap hints
│   │   └── yanky.lua                 # Clipboard history
│   │
│   ├── blink-cmp/                    # Completion engine config
│   │   └── setup.lua                 # blink.cmp setup (replaces nvim-cmp)
│   │
│   └── lsp/                          # LSP configuration
│       ├── common.lua                # Shared LSP on_attach and capabilities
│       ├── setup.lua                 # LSP server orchestration
│       ├── ui.lua                    # Diagnostic display config
│       ├── utils.lua                 # LSP utility functions
│       └── config/                   # Per-language server configs
│           ├── css.lua               # cssls
│           ├── json.lua              # jsonls + SchemaStore
│           ├── lua.lua               # lua_ls
│           ├── oxlint.lua            # oxlint (JS/TS linter)
│           ├── rust.lua              # rust_analyzer
│           ├── ts.lua                # vtsls (TypeScript)
│           ├── typos.lua             # typos_lsp
│           └── vue.lua               # vue_ls
│
├── lazy-lock.json                    # Plugin version lock
└── README.md
```

## 🏗️ Architecture

### Module Pattern

All plugin config modules follow the unified `M.setup()` pattern:

```lua
-- ╭──────────────────────────────────────────────────────────╮
-- │         plugin-name - Short Description                  │
-- ╰──────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  require("plugin-name").setup({
    -- options
  })
end

return M
```

### Separation of Concerns

| Layer | Directory | Responsibility |
|-------|-----------|---------------|
| **Plugin Specs** | `lua/plugins/` | lazy.nvim declarations (what to load, when) |
| **Plugin Config** | `lua/plugin-config/` | Implementation details (`M.setup()`) |
| **Keybindings** | `lua/config/keymaps.lua` | All keymaps centralized |
| **Commands** | `lua/config/commands.lua` | Plugin API wrappers for `<cmd>` syntax |
| **LSP** | `lua/lsp/` | Language server setup and configuration |
| **Completion** | `lua/blink-cmp/` | blink.cmp completion engine |

### Loading Flow

```
init.lua
  ├─ config/options.lua       (vim options, providers, fillchars)
  ├─ config/neovide.lua       (Neovide GUI settings, no-op in terminal)
  ├─ config/lazy.lua          (bootstrap lazy.nvim, load plugin specs)
  │   └─ plugins/*.lua        (lazy.nvim specs, all lazy by default)
  │       ├─ plugin-config/*.lua  (M.setup() on demand)
  │       ├─ lsp/setup.lua       (on BufReadPost/BufNewFile)
  │       └─ blink-cmp/setup.lua (on InsertEnter)
  └─ vim.schedule:
      ├─ config/autocmds.lua      (editor autocommands)
      ├─ config/commands.lua      (user commands)
      └─ config/keymap-validator.lua (dev tool)
  └─ VeryLazy event:
      └─ config/keymaps.lua       (global keymaps)
```

## 🗂️ Plugin Categories

### Completion & Snippets (`coding.lua`)
- **blink.cmp** — Completion engine (replaces nvim-cmp)
- **blink.compat** — nvim-cmp source compatibility layer
- **LuaSnip** — Snippet engine + friendly-snippets
- **rainbow-delimiters** — Rainbow brackets

### UI (`ui.lua`)
- **lualine** — Status line
- **bufferline** — Tab bar
- **noice.nvim** — Cmdline/notify/search UI
- **which-key** — Keymap hints
- **snacks.nvim** — Dashboard, terminal, utilities
- **dropbar** — Breadcrumb navigation
- **smart-splits** — Window management
- **reactive.nvim** — Mode cursor styling
- **markview/helpview** — Markdown/help rendering
- **log-highlight** — Log syntax highlighting

### Editor (`editor.lua`)
- **flash.nvim** — Quick motion navigation
- **multicursor.nvim** — Multiple cursors
- **yanky.nvim** — Clipboard history
- **nvim-autopairs** — Auto bracket pairing
- **todo-comments** — TODO comment highlighting
- **treesj** — Code split/join
- **origami** — Folding
- **tiny-glimmer** — Yank highlight animation
- **nvim-surround** — Surround operations with surround-ui visualization

### Navigation (`navigation.lua`)
- **telescope.nvim** — Fuzzy finder
- **harpoon** — Quick file navigation
- **oil.nvim** — File explorer (buffer-based)
- **nvim-tree** — File tree sidebar
- **aerial.nvim** — Symbol navigation (float window + outline sidebar)
- **grug-far** — Search and replace
- **project.nvim** — Project detection
- **auto-session** — Session management

### LSP (`lsp.lua`)
- **nvim-lspconfig** — LSP client
- **mason.nvim** — LSP/tool installer
- **lspsaga.nvim** — LSP UI enhancement
- **symbol-usage** — Symbol reference counts
- **lazydev.nvim** — Lua development
- **SchemaStore** — JSON schema support

### Git (`git.lua`)
- **gitsigns** — Git signs in gutter
- **neogit** — Git interface (Magit-inspired)
- **diffview** — Diff viewer

### Formatting (`formatting.lua`)
- **conform.nvim** — Code formatter (Prettier, Stylua, Black, rustfmt)
- Linting provided by **oxlint** LSP server (no standalone nvim-lint needed)

### Colorscheme (`colorscheme.lua`)
- **zephyr** — Primary color scheme with extensive highlight overrides
- **gruvbox / kanagawa / catppuccin** — Alternative colorschemes

### Language (`lang.lua`)
- **rustaceanvim** — Rust development enhancement
- **crates.nvim** — Rust crates management
- **tailwind-tools** — Tailwind CSS utilities
- **CodeCompanion** — AI coding assistant
- **CodeBuddy** — Internal AI plugin

## ⌨️ Key Bindings

Leader key: `<Space>`

### Essential Bindings

| Key | Action | Mode |
|-----|--------|------|
| `<leader>sf` | Search files | Normal |
| `<leader>sg` | Live grep | Normal |
| `<leader><space>` | Search buffers | Normal |
| `<leader>tt` | Toggle file tree | Normal |
| `<leader>cf` | Format buffer | Normal |
| `gd` | Go to definition | Normal |
| `K` | Hover documentation | Normal |
| `gr` | Show references | Normal |
| `<leader>ca` | Code actions | Normal |
| `<leader>fj` | Flash jump | Normal |
| `<leader>nb` | Symbol navigation (Aerial float) | Normal |
| `<leader>no` | Symbol outline (Aerial sidebar) | Normal |
| `<S-h>` / `<S-l>` | Previous/next buffer | Normal |
| `<C-h/j/k/l>` | Window navigation | Normal |

## 📦 LSP Servers

Automatically installed via Mason:

| Server | Language |
|--------|----------|
| `vtsls` | TypeScript/JavaScript |
| `vue_ls` | Vue |
| `rust_analyzer` | Rust |
| `lua_ls` | Lua |
| `cssls` | CSS |
| `tailwindcss` | Tailwind CSS |
| `html` | HTML |
| `jsonls` | JSON (with SchemaStore) |
| `taplo` | TOML |
| `zk` | Zettelkasten/Markdown |
| `oxlint` | JavaScript/TypeScript linting |
| `typos_lsp` | Typo detection |

## 🔧 Installation

### Prerequisites

- **Neovim 0.11+** (required for `vim.lsp.config`, `winborder`, etc.)
- **Nerd Font** — set as terminal font (recommended: Maple Mono NF)
- **Node.js & npm** — for formatters and some LSPs
- **Rust toolchain** — for rust-analyzer and stylua
- **ripgrep** — for Telescope live grep
- **fd** — for Telescope find files (optional, faster than `find`)

### Setup

```bash
git clone <your-repo-url> ~/.config/nvim
nvim  # Plugins install automatically on first launch
```

## 🔍 Useful Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Plugin manager dashboard |
| `:Lazy profile` | Startup time analysis |
| `:Mason` | LSP/tool installer |
| `:LspInfo` | Active LSP servers |
| `:KeymapValidate` | Check keymap conflicts |
| `:KeymapValidate!` | Keymap statistics |
| `:ConformInfo` | Formatter status |

## 🚀 Performance

- **Startup time**: ~30ms (measured with `--startuptime`)
- `vim.loader.enable()` for Lua module caching
- All plugins lazy by default via lazy.nvim
- Disabled built-in plugins: gzip, netrw, matchit, tar, tohtml, tutor, zip
- Key-driven lazy loading: plugins like smart-splits, yanky, lspsaga, aerial load only on first keypress
- Optimized autocmds: `FileType` over `BufEnter`, no `CursorHoldI` for checktime
- Reduced animation overhead: notification fps capped at 30
- Neovide idle rendering disabled to save CPU/GPU
- LSP loads on `BufReadPost/BufNewFile`, completion on `InsertEnter`
- Keymaps and autocmds deferred via `vim.schedule`
- Disabled unused providers (perl, ruby, node, python3)
- Large file protection: skip treesitter highlight (>10000 lines), skip formatting (>200KB)

## 📝 Adding a New Plugin

1. Add plugin spec to the appropriate file in `lua/plugins/`
2. Create `lua/plugin-config/<name>.lua` following the `M.setup()` pattern
3. Add keymaps to `lua/config/keymaps.lua`
4. Add commands to `lua/config/commands.lua` if needed

## 📄 License

This configuration is provided as-is for personal use.

## 🔍 Troubleshooting

### Startup Issues

| Issue | Solution |
|-------|----------|
| Plugins not loading | `:Lazy sync` to install/update all plugins |
| LSP not starting | `:LspInfo` to check server status, `:Mason` to verify installation |
| Icons missing | Install a Nerd Font and set it as your terminal font |
| Slow startup | `:Lazy profile` to identify bottlenecks |
| Treesitter errors | `:TSUpdate` to update parsers |
| Keybinding conflicts | `:KeymapValidate` to detect conflicts |
| Formatter not working | `:ConformInfo` to check formatter availability |
| prettierd errors | Run `:MasonToolsUpdate` to reinstall with prettier dep |

### Common Errors

**"module 'xxx' not found"**
- Plugin not installed: run `:Lazy sync`
- Module path wrong: check `lua/` directory structure

**"LSP server xxx not installed"**
- Run `:Mason` and install the missing server
- Or add to `ensure_installed` in `lsp.lua`

**"Formatter 'oxfmt' error"**
- oxfmt requires `.oxfmtrc.json` in project root
- Projects without oxfmt config will fallback to prettierd

**"Cannot find module 'prettier'"**
- Run `:MasonToolsUpdate` which auto-installs prettier for prettierd
- Or manually: `cd ~/.local/share/nvim/mason/packages/prettierd && npm install prettier`

### Health Check

```vim
:checkhealth             " Full health check
:checkhealth lazy        " Check lazy.nvim
:checkhealth mason       " Check Mason
:checkhealth lspconfig   " Check LSP configs
```
