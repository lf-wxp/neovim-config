<div align="center">

# Neovim Configuration

A modular, performance-optimized Lua-based Neovim IDE built on **lazy.nvim**.

<p>
  <img alt="Neovim" src="https://img.shields.io/badge/Neovim-0.11%2B-57A143?logo=neovim&logoColor=white">
  <img alt="Lua" src="https://img.shields.io/badge/Made%20with-Lua-2C2D72?logo=lua&logoColor=white">
  <img alt="lazy.nvim" src="https://img.shields.io/badge/plugins-lazy.nvim-blueviolet">
  <img alt="Startup" src="https://img.shields.io/badge/startup-~30ms-brightgreen">
</p>

</div>

---

## ✨ Highlights

| | |
|---|---|
| 🧩 **Modular** | Every plugin has its own spec + `M.setup()` config module |
| 🎛️ **Centralized Toggle** | Enable/disable any plugin from a single file |
| ⚡ **Fast** | Lazy loading everywhere — ~30ms startup |
| 🧠 **Modern LSP** | Native `vim.lsp.config` (Neovim 0.11+), no `lspconfig.setup()` |
| ⌨️ **Centralized Keymaps** | All bindings live in `keymaps.lua` — no hardcoding in plugins |
| 🎨 **Clean UI** | Borderless floating windows, animated dashboard, minimal aesthetics |

**Out of the box:**

- **Completion** — blink.cmp (replaces nvim-cmp) with LuaSnip snippets
- **LSP** — TypeScript/JavaScript, Vue, Rust, Lua, CSS, HTML, JSON, TOML, Tailwind
- **Formatting** — conform.nvim with oxfmt / prettierd auto-detection
- **Git** — Gitsigns, Neogit, Diffview, Git-Conflict
- **Navigation** — Telescope, Harpoon, Oil, nvim-tree, Flash, Aerial
- **AI** — CodeCompanion

---

## 📁 Project Structure

```
~/.config/nvim/
├── init.lua                     # Entry point
├── lazy-lock.json               # Plugin version lock
└── lua/
    ├── config/                  # ── Core configuration ──
    │   ├── options.lua          #   Vim options
    │   ├── keymaps.lua          #   All keybindings (centralized)
    │   ├── autocmds.lua         #   Autocommands
    │   ├── commands.lua         #   User commands
    │   ├── lazy.lua             #   lazy.nvim bootstrap
    │   ├── plugin-toggle.lua    #   Centralized enable/disable switch
    │   ├── keymap-validator.lua #   Keymap conflict detection (dev tool)
    │   ├── neovide.lua          #   Neovide GUI config
    │   └── utils.lua            #   Utility functions
    │
    ├── plugins/                 # ── Plugin specs (lazy.nvim declarations) ──
    │   ├── coding.lua           #   Completion, snippets, brackets
    │   ├── ui.lua               #   UI components + dashboard
    │   ├── editor.lua           #   Editor enhancements
    │   ├── navigation.lua       #   File navigation & search
    │   ├── lsp.lua              #   LSP core plugins
    │   ├── git.lua              #   Git integration
    │   ├── formatting.lua       #   Formatters & linters
    │   ├── lang.lua             #   Language-specific plugins
    │   └── colorscheme.lua       #   Themes & highlight overrides
    │
    ├── plugin-config/           # ── Plugin implementations (M.setup()) ──
    │   └── *.lua                #   One module per plugin (telescope, oil, …)
    │
    ├── blink-cmp/               # ── Completion engine ──
    │   └── setup.lua            #   blink.cmp setup
    │
    └── lsp/                     # ── LSP configuration ──
        ├── setup.lua            #   Server orchestration (vim.lsp.enable)
        ├── common.lua           #   Shared on_attach, keymaps, codelens
        ├── ui.lua               #   Diagnostic display
        ├── utils.lua            #   LSP utilities
        └── config/              #   Per-server settings (ts, vue, lua, css, …)
```

> **Note:** Rust is handled by **rustaceanvim** (not a `lsp/config/` file), which
> owns its own `rust-analyzer` client and settings.

---

## 🏗️ Architecture

### Module Pattern

Every plugin config module follows the unified `M.setup()` convention:

```lua
-- ╭──────────────────────────────────────────────────────────╮
-- │         plugin-name - Short Description                    │
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
|-------|-----------|----------------|
| **Toggle** | `config/plugin-toggle.lua` | Centralized enable/disable switch |
| **Specs** | `plugins/` | lazy.nvim declarations (what to load, when) |
| **Config** | `plugin-config/` | Implementation details (`M.setup()`) |
| **Keymaps** | `config/keymaps.lua` | All keymaps, centralized |
| **Commands** | `config/commands.lua` | Plugin API wrappers for `<cmd>` syntax |
| **LSP** | `lsp/` | Language server setup & configuration |
| **Completion** | `blink-cmp/` | blink.cmp completion engine |

### Loading Flow

```
init.lua
 ├─ config/options.lua        (vim options, providers, fillchars)
 ├─ config/neovide.lua        (GUI settings, no-op in terminal)
 ├─ config/lazy.lua           (bootstrap lazy.nvim → load specs)
 │   └─ plugins/*.lua         (all lazy by default)
 │       ├─ plugin-config/*   (M.setup() on demand)
 │       ├─ lsp/setup.lua     (on BufReadPost / BufNewFile)
 │       └─ blink-cmp/setup   (on InsertEnter)
 ├─ vim.schedule:             (autocmds, commands, keymap-validator)
 └─ VeryLazy:                 (global keymaps)
```

---

## 🗂️ Plugins by Category

<details open>
<summary><b>Completion &amp; Snippets</b> — <code>coding.lua</code></summary>

- **blink.cmp** — Completion engine (replaces nvim-cmp)
- **blink.compat** — nvim-cmp source compatibility layer
- **LuaSnip** — Snippet engine + friendly-snippets
- **rainbow-delimiters** — Rainbow brackets

</details>

<details>
<summary><b>UI</b> — <code>ui.lua</code></summary>

- **snacks.nvim** — Dashboard (with milli animated splash), terminal, utilities
- **lualine** — Statusline (shows current buffer's LSP clients)
- **bufferline** — Tab bar
- **noice.nvim** — Cmdline / notify / search UI
- **which-key** — Keymap hints
- **dropbar** — Breadcrumb navigation
- **smart-splits** — Window management
- **reactive.nvim** — Mode-based cursor styling
- **markview / helpview** — Markdown / help rendering
- **log-highlight** — Log syntax highlighting

</details>

<details>
<summary><b>Editor</b> — <code>editor.lua</code></summary>

- **flash.nvim** — Quick motion navigation
- **multicursor.nvim** — Multiple cursors
- **yanky.nvim** — Clipboard history
- **nvim-autopairs** — Auto bracket pairing
- **Comment.nvim** — Smart comment toggling (line/block)
- **dial.nvim** — Enhanced increment/decrement (dates, booleans, semver…)
- **todo-comments** — TODO comment highlighting
- **treesj** — Code split/join
- **origami** — Folding
- **tiny-glimmer** — Yank highlight animation
- **nvim-surround** — Surround operations with visualization

</details>

<details>
<summary><b>Navigation</b> — <code>navigation.lua</code></summary>

- **telescope.nvim** — Fuzzy finder
- **harpoon** — Quick file navigation
- **oil.nvim** — File explorer (buffer-based)
- **nvim-tree** — File tree sidebar
- **aerial.nvim** — Symbol navigation (float + outline sidebar)
- **grug-far** — Search and replace
- **project.nvim** — Project detection
- **auto-session** — Session management

</details>

<details>
<summary><b>LSP</b> — <code>lsp.lua</code></summary>

- **nvim-lspconfig** — Server config data source (native `vim.lsp` client)
- **mason.nvim** — LSP / tool installer
- **lspsaga.nvim** — LSP UI enhancement
- **symbol-usage** — Inline reference / def / impl counts
- **lazydev.nvim** — Lua development
- **SchemaStore** — JSON schema support

</details>

<details>
<summary><b>Git</b> — <code>git.lua</code></summary>

- **gitsigns** — Git signs in gutter
- **neogit** — Git interface (Magit-inspired)
- **diffview** — Diff viewer
- **git-conflict** — Inline conflict resolution (ours/theirs/both/none)

</details>

<details>
<summary><b>Formatting</b> — <code>formatting.lua</code></summary>

- **conform.nvim** — Formatter (Prettier, Stylua, Black, rustfmt)
- Linting provided by the **oxlint** LSP server (no standalone nvim-lint)

</details>

<details>
<summary><b>Language</b> — <code>lang.lua</code></summary>

- **rustaceanvim** — Rust development (owns rust-analyzer + clippy on save)
- **crates.nvim** — Rust crates management
- **tailwind-tools** — Tailwind CSS utilities
- **CodeCompanion** — AI coding assistant

</details>

<details>
<summary><b>Colorscheme</b> — <code>colorscheme.lua</code></summary>

- **zephyr** — Primary theme (extensive highlight overrides)
- **gruvbox / kanagawa / catppuccin** — Alternatives

</details>

---

## ⌨️ Key Bindings

Leader key: <kbd>Space</kbd>

| Key | Action |
|-----|--------|
| `<leader>sf` | Search files |
| `<leader>sg` | Live grep |
| `<leader><space>` | Search buffers |
| `<leader>tt` | Toggle file tree |
| `<leader>cf` | Format buffer |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `gr` | Show references |
| `<leader>ca` | Code actions |
| `<leader>fj` | Flash jump |
| `<leader>nb` | Symbol navigation (Aerial float) |
| `<leader>no` | Symbol outline (Aerial sidebar) |
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `<C-h/j/k/l>` | Window navigation |

> Run `:KeymapValidate` to check for conflicts, or press <kbd>Space</kbd> and wait
> for **which-key** hints.

---

## 📦 LSP Servers

Managed via Mason and enabled through native `vim.lsp.enable`:

| Server | Language | Notes |
|--------|----------|-------|
| `vtsls` | TypeScript / JavaScript | |
| `vue_ls` | Vue | |
| `rust_analyzer` | Rust | via **rustaceanvim** (clippy on save) |
| `lua_ls` | Lua | |
| `cssls` | CSS | |
| `tailwindcss` | Tailwind CSS | |
| `html` | HTML | |
| `jsonls` | JSON | with SchemaStore |
| `taplo` | TOML | |
| `zk` | Markdown / Zettelkasten | |
| `oxlint` | JS/TS linting | LSP-based linter |
| `typos_lsp` | Typo detection | |

---

## 🔧 Installation

### Prerequisites

| Requirement | Purpose |
|-------------|---------|
| **Neovim 0.11+** | Native `vim.lsp.config`, `winborder`, etc. |
| **Nerd Font** | Icons (recommended: Maple Mono NF) |
| **Node.js & npm** | Formatters & some LSPs |
| **Rust toolchain** | rust-analyzer, stylua |
| **tree-sitter CLI** | Compile Treesitter parsers ([see below](#-tree-sitter-cli)) |
| **ripgrep** | Telescope live grep |
| **fd** | Telescope find files (optional, faster) |

### Setup

```bash
git clone <your-repo-url> ~/.config/nvim
nvim   # plugins install automatically on first launch
```

###🌳 tree-sitter CLI

This config uses the **`main` branch** of nvim-treesitter, which compiles parsers
with the standalone **`tree-sitter` CLI** instead of a C compiler.

> ⚠️ Homebrew's `tree-sitter` formula only ships the **C library**, not the CLI.

```bash
cargo install tree-sitter-cli     # recommended (full-featured)
npm install -g tree-sitter-cli    # alternative
```

The config **auto-detects a missing CLI on startup** and installs it (cargo → npm
→ brew). After install, run `:TSInstallEnsure` or restart. If launched from a GUI
(e.g. Neovide) and the CLI still isn't found, ensure its bin dir (e.g.
`~/.cargo/bin`) is on Neovim's `PATH`.

---

## 🔍 Useful Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Plugin manager dashboard |
| `:Lazy profile` | Startup time analysis |
| `:Mason` | LSP / tool installer |
| `:checkhealth vim.lsp` | LSP status (clients also shown in statusline) |
| `:ConformInfo` | Formatter status |
| `:TSInstallEnsure` | Compile missing Treesitter parsers |
| `:KeymapValidate` | Check keymap conflicts (`!` for stats) |

---

## 🚀 Performance

Target startup **~30ms** (measured with `--startuptime`). Techniques used:

- `vim.loader.enable()` for Lua module bytecode caching
- All plugins lazy by default (event / key / cmd / ft triggers)
- LSP loads on `BufReadPost`/`BufNewFile`, completion on `InsertEnter`
- Keymaps & autocmds deferred via `vim.schedule` / `VeryLazy`
- Disabled built-in plugins: gzip, netrw, matchit, tar, tohtml, tutor, zip
- Disabled unused providers: perl, ruby, node, python3
- Large-file protection: skip Treesitter highlight (>10k lines), skip format (>200KB)
- Neovide idle rendering disabled; notification fps capped at 30

---

## 🔌 Plugin Toggle

Every plugin can be enabled/disabled from a single file:
`lua/config/plugin-toggle.lua`.

```lua
M.plugins = {
  ["codecompanion"] = false,      -- disable AI assistant
  ["cellular-automaton"] = false, -- disable fun plugin
  -- ...
}
```

Plugins **not listed default to enabled**, so newly added plugins work with no
extra config. Run `:Lazy sync` after editing.

---

## 📝 Adding a New Plugin

1. Add the spec to the appropriate file in `lua/plugins/`
2. Add `enabled = toggle.is_enabled("plugin-name")` to the spec
3. (Optional) register it in `lua/config/plugin-toggle.lua`
4. Create `lua/plugin-config/<name>.lua` following the `M.setup()` pattern
5. Add keymaps to `lua/config/keymaps.lua`
6. Add commands to `lua/config/commands.lua` if needed

---

## 🩺 Troubleshooting

| Issue | Solution |
|-------|----------|
| Plugins not loading | `:Lazy sync` |
| LSP not starting | `:checkhealth vim.lsp`, `:Mason` (clients show in statusline) |
| Icons missing | Install a Nerd Font and set it as your terminal font |
| Slow startup | `:Lazy profile` |
| Treesitter errors | `:TSInstallEnsure` |
| Keybinding conflicts | `:KeymapValidate` |
| Formatter not working | `:ConformInfo` |
| **Oil changes not applied** | Oil stages edits — save with `:w` to write them to disk |

### Common Errors

<details>
<summary><b><code>module 'xxx' not found</code></b></summary>

- Plugin not installed → `:Lazy sync`
- Wrong module path → check the `lua/` directory structure

</details>

<details>
<summary><b><code>LSP server xxx not installed</code></b></summary>

- Run `:Mason` and install the missing server, or add it to `ensure_installed`
  in `lsp.lua`

</details>

<details>
<summary><b><code>Formatter 'oxfmt' error</code></b></summary>

- oxfmt requires `.oxfmtrc.json` in the project root
- Projects without an oxfmt config fall back to prettierd

</details>

<details>
<summary><b><code>Cannot find module 'prettier'</code></b></summary>

- Run `:MasonToolsUpdate` (auto-installs prettier for prettierd), or manually:
  `cd ~/.local/share/nvim/mason/packages/prettierd && npm install prettier`

</details>

<details>
<summary><b><code>Error during 'tree-sitter build': ENOENT (cmd): 'tree-sitter'</code></b></summary>

- The `tree-sitter` CLI is missing from `PATH`:
  `cargo install tree-sitter-cli` (or `npm install -g tree-sitter-cli`)
- Homebrew's `tree-sitter` formula does **not** provide the CLI (C library only)
- After installing, run `:TSInstallEnsure` or restart Neovim
- From a GUI (Neovide) still failing → add `~/.cargo/bin` to Neovim's `PATH`

</details>

### Health Check

```vim
:checkhealth             " Full health check
:checkhealth lazy        " lazy.nvim
:checkhealth mason       " Mason
:checkhealth vim.lsp     " Active LSP clients (native)
```

---

## 📄 License

Provided as-is for personal use.
