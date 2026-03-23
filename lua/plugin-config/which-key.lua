-- ╭────────────────────────────────────────────────────────╮
-- │                 Which-Key Configuration                │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local which_key = require("which-key")

  which_key.setup({
  icons = {
    -- Disable icon decorations (e.g. underline)
    separator = "",
    -- Set base icon style
    group = "",
    -- Rule configuration
    rules = {
      -- ========================================
      -- Window & Split
      -- ========================================
      { pattern = "split vertical", icon = "󰤼", color = "cyan" },
      { pattern = "split horizontal", icon = "󰤻", color = "cyan" },
      { pattern = "close window", icon = "󰖭", color = "red" },
      { pattern = "close other windows", icon = "󰗨", color = "red" },
      { pattern = "go left window", icon = "󰁍", color = "blue" },
      { pattern = "go right window", icon = "󰁔", color = "blue" },
      { pattern = "go up window", icon = "󰁝", color = "blue" },
      { pattern = "go down window", icon = "󰁅", color = "blue" },
      { pattern = "window width", icon = "󰩨", color = "cyan" },
      { pattern = "window height", icon = "󰩩", color = "cyan" },
      { pattern = "equal windows", icon = "󰕭", color = "green" },
      { pattern = "windows", icon = "󰖲", color = "blue" },
      { pattern = "split", icon = "󰘶", color = "cyan" },
      { pattern = "window", icon = "󰖲", color = "blue" },

      -- ========================================
      -- Navigation
      -- ========================================
      { pattern = "file tree", icon = "󱏒", color = "green" },
      { pattern = "tree", icon = "󱏒", color = "green" },
      { pattern = "open parent dir", icon = "󰁝", color = "blue" },
      { pattern = "oil float", icon = "󰉖", color = "blue" },
      { pattern = "symbol navigation", icon = "󰧮", color = "purple" },
      { pattern = "symbol outline", icon = "󰧮", color = "purple" },
      { pattern = "aerial", icon = "󰯈", color = "purple" },
      { pattern = "navigate forward", icon = "󰒭", color = "blue" },
      { pattern = "navigate backward", icon = "󰕍", color = "blue" },
      { pattern = "go back", icon = "󰕍", color = "blue" },
      { pattern = "go forward", icon = "󰒭", color = "blue" },
      { pattern = "jump", icon = "󰆾", color = "blue" },
      { pattern = "scroll up", icon = "󰶣", color = "cyan" },
      { pattern = "scroll down", icon = "󰶡", color = "cyan" },
      { pattern = "page up", icon = "󰶣", color = "cyan" },
      { pattern = "page down", icon = "󰶡", color = "cyan" },
      { pattern = "half", icon = "󰕫", color = "cyan" },
      { pattern = "full page", icon = "󱗚", color = "cyan" },
      -- Screen scroll position
      { pattern = "cursor to top", icon = "󰁝", color = "cyan" },
      { pattern = "cursor to bottom", icon = "󰁅", color = "cyan" },
      { pattern = "cursor to center", icon = "󰡌", color = "cyan" },
      { pattern = "scroll left", icon = "󰁍", color = "cyan" },
      { pattern = "scroll right", icon = "󰁔", color = "cyan" },
      { pattern = "dashboard", icon = "󰕮", color = "blue" },
      { pattern = "next", icon = "󰒭", color = "blue" },
      { pattern = "prev", icon = "󰒮", color = "blue" },
      { pattern = "list", icon = "󰷐", color = "blue" },
      { pattern = "outline", icon = "󰧮", color = "purple" },

      -- ========================================
      -- Flash
      -- ========================================
      { pattern = "flash treesitter", icon = "󰐅", color = "green" },
      { pattern = "flash jump", icon = "󱐋", color = "yellow" },
      { pattern = "flash", icon = "󱐋", color = "yellow" },

      -- ========================================
      -- Editing
      -- ========================================
      { pattern = "move selection", icon = "󰜴", color = "blue" },
      { pattern = "surround", icon = "󰅪", color = "orange" },
      { pattern = "paste from clipboard", icon = "󰆒", color = "azure" },
      { pattern = "copy to clipboard", icon = "󰆏", color = "azure" },
      { pattern = "paste", icon = "󰆒", color = "azure" },
      { pattern = "copy", icon = "󰆏", color = "azure" },
      { pattern = "yank", icon = "󰆏", color = "azure" },
      { pattern = "clear search highlight", icon = "󰹊", color = "grey" },
      { pattern = "highlight", icon = "󰸱", color = "yellow" },
      { pattern = "rename", icon = "󰑕", color = "orange" },
      { pattern = "replace in file", icon = "󰛔", color = "orange" },
      { pattern = "project search replace", icon = "󰛔", color = "orange" },
      { pattern = "search word", icon = "󰗧", color = "yellow" },
      { pattern = "replace", icon = "󰲢", color = "orange" },
      { pattern = "format", icon = "󰉼", color = "green" },
      { pattern = "edit", icon = "󰔨", color = "blue" },
      { pattern = "select", icon = "󰒆", color = "blue" },
      { pattern = "toggle split/join", icon = "󰯋", color = "green" },
      { pattern = "swap next", icon = "󰓡", color = "blue" },
      { pattern = "swap prev", icon = "󰓢", color = "blue" },
      { pattern = "swap parameter", icon = "󰓡", color = "blue" },
      { pattern = "swap", icon = "󰓡", color = "blue" },

      -- ========================================
      -- Text Objects
      -- ========================================
      { pattern = "inside", icon = "󰟵", color = "cyan" },
      { pattern = "around", icon = "󰟶", color = "cyan" },
      { pattern = "inner", icon = "󰟵", color = "cyan" },
      { pattern = "text object", icon = "󰅳", color = "cyan" },
      -- Brackets
      { pattern = "%[%]", icon = "󰅪", color = "orange" },
      { pattern = "<>", icon = "󰅩", color = "cyan" },
      { pattern = "bracket", icon = "󰅪", color = "orange" },
      { pattern = "quote", icon = "󰅴", color = "yellow" },
      { pattern = "string", icon = "󰅳", color = "green" },

      -- ========================================
      -- Buffer & Tab
      -- ========================================
      { pattern = "delete buffer", icon = "󰅖", color = "red" },
      { pattern = "delete other buffers", icon = "󰗨", color = "red" },
      { pattern = "close right tabs", icon = "󰁔", color = "red" },
      { pattern = "close left tabs", icon = "󰁍", color = "red" },
      { pattern = "pick close tab", icon = "󰓾", color = "red" },
      { pattern = "close tab", icon = "󰅖", color = "red" },
      { pattern = "prev tab", icon = "󰁍", color = "blue" },
      { pattern = "next tab", icon = "󰁔", color = "blue" },
      { pattern = "move tab left", icon = "󰜱", color = "blue" },
      { pattern = "move tab right", icon = "󰜴", color = "blue" },
      { pattern = "pick tab", icon = "󰓾", color = "blue" },
      { pattern = "buffer", icon = "󰓩", color = "blue" },
      { pattern = "buffers", icon = "󰓩", color = "blue" },
      { pattern = "tab", icon = "󰓫", color = "blue" },

      -- ========================================
      -- Search & Telescope
      -- ========================================
      { pattern = "find files", icon = "󰈞", color = "blue" },
      { pattern = "live grep", icon = "󱎸", color = "yellow" },
      { pattern = "projects", icon = "󰉖", color = "blue" },
      { pattern = "colorscheme", icon = "󰏘", color = "yellow" },
      { pattern = "file browser", icon = "󰉖", color = "blue" },
      { pattern = "keymaps", icon = "󰌌", color = "yellow" },
      { pattern = "telescope", icon = "󰭎", color = "blue" },
      { pattern = "find", icon = "󰮗", color = "blue" },
      { pattern = "grep", icon = "󱎸", color = "yellow" },
      { pattern = "search", icon = "󰍉", color = "yellow" },

      -- ========================================
      -- Git
      -- ========================================
      { pattern = "open neogit", icon = "󰊢", color = "green" },
      { pattern = "neogit", icon = "󰊢", color = "green" },
      { pattern = "lazygit", icon = "󰊢", color = "green" },
      { pattern = "next hunk", icon = "󰒭", color = "blue" },
      { pattern = "prev hunk", icon = "󰒮", color = "blue" },
      { pattern = "stage hunk", icon = "󰅰", color = "green" },
      { pattern = "stage buffer", icon = "󰅰", color = "green" },
      { pattern = "undo stage", icon = "󰕌", color = "yellow" },
      { pattern = "reset hunk", icon = "󰜉", color = "red" },
      { pattern = "reset buffer", icon = "󰜉", color = "red" },
      { pattern = "preview hunk", icon = "󰈈", color = "yellow" },
      { pattern = "blame line", icon = "󰈀", color = "grey" },
      { pattern = "diff this", icon = "󰦫", color = "cyan" },
      { pattern = "diff all", icon = "󰦫", color = "cyan" },
      { pattern = "toggle deleted", icon = "󰔡", color = "cyan" },
      { pattern = "toggle line blame", icon = "󰔡", color = "cyan" },
      { pattern = "select hunk", icon = "󰒆", color = "blue" },
      { pattern = "git", icon = "󰊢", color = "green" },
      { pattern = "diff", icon = "󰦫", color = "cyan" },
      { pattern = "stage", icon = "󰅰", color = "green" },
      { pattern = "hunk", icon = "󰠖", color = "yellow" },
      { pattern = "blame", icon = "󰈀", color = "grey" },
      { pattern = "reset", icon = "󰜉", color = "red" },

      -- ========================================
      -- Harpoon
      -- ========================================
      { pattern = "harpoon add", icon = "󰐕", color = "green" },
      { pattern = "harpoon toggler", icon = "󱋡", color = "blue" },
      { pattern = "open harpoon", icon = "󱋡", color = "blue" },
      { pattern = "harpoon prev", icon = "󰁍", color = "blue" },
      { pattern = "harpoon next", icon = "󰁔", color = "blue" },
      { pattern = "harpoon file", icon = "󰓾", color = "blue" },
      { pattern = "harpoon", icon = "󱋡", color = "blue" },

      -- ========================================
      -- Terminal
      -- ========================================
      { pattern = "float terminal", icon = "󰀻", color = "green" },
      { pattern = "right terminal", icon = "󰁔", color = "green" },
      { pattern = "bottom terminal", icon = "󰘯", color = "green" },
      { pattern = "terminal", icon = "󰆍", color = "green" },
      { pattern = "toggle", icon = "󰔠", color = "cyan" },

      -- ========================================
      -- LSP
      -- ========================================
      { pattern = "go to definition", icon = "󰈮", color = "blue" },
      { pattern = "hover doc", icon = "󰋽", color = "blue" },
      { pattern = "hover definition", icon = "󰋽", color = "blue" },
      { pattern = "peek declaration", icon = "󰙴", color = "blue" },
      { pattern = "peek definition", icon = "󰈮", color = "blue" },
      { pattern = "peek implementation", icon = "󰆧", color = "cyan" },
      { pattern = "peek references", icon = "󰆽", color = "yellow" },
      { pattern = "peek type", icon = "󰜢", color = "cyan" },
      { pattern = "type definition", icon = "󰜢", color = "cyan" },
      { pattern = "find references", icon = "󰆽", color = "yellow" },
      { pattern = "line diagnostics", icon = "󰁨", color = "red" },
      { pattern = "next diagnostic", icon = "󰒭", color = "blue" },
      { pattern = "prev diagnostic", icon = "󰒮", color = "blue" },
      { pattern = "code action", icon = "󰅗", color = "green" },
      { pattern = "toggle inlay hints", icon = "󰊠", color = "cyan" },
      { pattern = "inlay hint", icon = "󰊠", color = "cyan" },
      { pattern = "codelens run", icon = "󰜎", color = "green" },
      { pattern = "codelens", icon = "󰜎", color = "green" },
      { pattern = "document symbols", icon = "󰧮", color = "purple" },
      { pattern = "workspace symbols", icon = "󱃖", color = "blue" },
      { pattern = "signature help", icon = "󰋽", color = "yellow" },
      { pattern = "diagnostic", icon = "󰁨", color = "red" },
      { pattern = "definition", icon = "󰈮", color = "blue" },
      { pattern = "reference", icon = "󰆽", color = "yellow" },
      { pattern = "implementation", icon = "󰆧", color = "cyan" },
      { pattern = "declaration", icon = "󰙴", color = "blue" },
      { pattern = "hover", icon = "󰋽", color = "blue" },
      { pattern = "lsp", icon = "󰒒", color = "blue" },
      { pattern = "preview", icon = "󰈈", color = "yellow" },
      { pattern = "actions", icon = "󰅗", color = "green" },

      -- ========================================
      -- Color Picker (ccc.nvim)
      -- ========================================
      { pattern = "color pick", icon = "󰏘", color = "yellow" },
      { pattern = "color convert", icon = "󰴓", color = "yellow" },

      -- ========================================
      -- Crates.nvim
      -- ========================================
      { pattern = "crate toggle", icon = "󰔡", color = "cyan" },
      { pattern = "crate reload", icon = "󰑓", color = "cyan" },
      { pattern = "crate versions", icon = "󰦨", color = "blue" },
      { pattern = "crate features", icon = "󰃥", color = "yellow" },
      { pattern = "crate dependencies", icon = "󱃖", color = "blue" },
      { pattern = "crate update", icon = "󰚰", color = "green" },
      { pattern = "crate upgrade all", icon = "󰁝", color = "green" },
      { pattern = "crate upgrade", icon = "󰁝", color = "green" },
      { pattern = "crate homepage", icon = "󰖟", color = "blue" },
      { pattern = "crate repository", icon = "󰳐", color = "blue" },
      { pattern = "crate documentation", icon = "󰈙", color = "blue" },
      { pattern = "crate crates.io", icon = "󰆧", color = "blue" },
      { plugin = "crates.nvim", pattern = "crate", icon = "󰏖", color = "blue" },

      -- ========================================
      -- Multicursor
      -- ========================================
      { pattern = "add cursor", icon = "󰐕", color = "cyan" },
      { pattern = "skip cursor", icon = "󰜺", color = "grey" },
      { pattern = "toggle cursor", icon = "󰔡", color = "cyan" },
      { pattern = "delete cursor", icon = "󰩺", color = "red" },
      { pattern = "cursor", icon = "󰇀", color = "cyan" },
      { pattern = "multiple", icon = "󰳽", color = "cyan" },
      { pattern = "next match", icon = "󰒭", color = "blue" },
      { pattern = "prev match", icon = "󰒮", color = "blue" },
      { pattern = "match", icon = "󰛳", color = "yellow" },

      -- ========================================
      -- Snacks & Dashboard
      -- ========================================
      { pattern = "dashboard", icon = "󰕮", color = "blue" },
      { pattern = "snacks", icon = "󱥁", color = "yellow" },
      { pattern = "delete other buffers", icon = "󰗨", color = "red" },

      -- ========================================
      -- Run & Debug
      -- ========================================
      { pattern = "run snippet", icon = "󰜎", color = "green" },
      { pattern = "run code", icon = "󰜎", color = "green" },
      { pattern = "sniprun", icon = "󰒆", color = "green" },
      { pattern = "run", icon = "󰜎", color = "green" },
      { pattern = "test", icon = "󰔱", color = "green" },
      { pattern = "debug", icon = "󰃤", color = "red" },
      { pattern = "build", icon = "󱃖", color = "green" },

      -- ========================================
      -- Comments
      -- ========================================
      { pattern = "comment", icon = "󰆉", color = "grey" },
      { pattern = "annotation", icon = "󰏣", color = "grey" },
      { pattern = "todo", icon = "󰸞", color = "yellow" },

      -- ========================================
      -- Session & History
      -- ========================================
      { pattern = "restore session", icon = "󰦛", color = "blue" },
      { pattern = "save session", icon = "󰆓", color = "green" },
      { pattern = "delete session", icon = "󰩺", color = "red" },
      { pattern = "session", icon = "󰖲", color = "blue" },
      { pattern = "undo", icon = "󰕌", color = "yellow" },
      { pattern = "redo", icon = "󰑑", color = "orange" },
      { pattern = "history", icon = "󰋚", color = "yellow" },
      { pattern = "bookmark", icon = "󰸃", color = "yellow" },
      { pattern = "mark", icon = "󰈻", color = "yellow" },

      -- ========================================
      -- Tools & Package Manager
      -- ========================================
      { pattern = "lazy", icon = "󰒲", color = "blue" },
      { pattern = "mason", icon = "󱌢", color = "yellow" },
      { pattern = "package", icon = "󰏖", color = "yellow" },
      { pattern = "plugin", icon = "󰜪", color = "blue" },
      { pattern = "setting", icon = "󰢻", color = "grey" },
      { pattern = "config", icon = "󰢻", color = "grey" },
      { pattern = "help", icon = "󰋖", color = "blue" },
      { pattern = "command", icon = "󰞔", color = "grey" },

      -- ========================================
      -- File Operations
      -- ========================================
      { pattern = "file", icon = "󰈔", color = "blue" },
      { pattern = "close", icon = "󰅖", color = "red" },
      { pattern = "delete", icon = "󰩺", color = "red" },
      { pattern = "save", icon = "󰆓", color = "green" },
      { pattern = "open", icon = "󰝋", color = "green" },
      { pattern = "quit", icon = "󰩈", color = "red" },
      { pattern = "oil", icon = "󰈚", color = "blue" },

      -- ========================================
      -- Fold & View
      -- ========================================
      -- zc/zM - fold (close fold/more fold/fold all) - use fold icon
      { pattern = "close fold", icon = "󰁂", color = "purple" },
      { pattern = "more fold", icon = "󰁂", color = "purple" },
      -- zo/zr/zR - unfold (open fold/reduce fold/open all) - use unfold icon
      { pattern = "open fold", icon = "󰁌", color = "blue" },
      { pattern = "reduce fold", icon = "󰁌", color = "blue" },
      -- za - toggle fold
      { pattern = "toggle fold", icon = "󰔡", color = "cyan" },
      -- Generic fold patterns
      { pattern = "fold", icon = "󰁂", color = "purple" },
      { pattern = "unfold", icon = "󰁌", color = "blue" },

      -- ========================================
      -- Yanky
      -- ========================================
      { pattern = "yank history", icon = "󰋚", color = "yellow" },
      { pattern = "clipboard history", icon = "󰋚", color = "yellow" },
      { pattern = "next clipboard", icon = "󰒭", color = "azure" },
      { pattern = "prev clipboard", icon = "󰒮", color = "azure" },
      { pattern = "paste after", icon = "󰆒", color = "azure" },
      { pattern = "paste before", icon = "󰅑", color = "azure" },
      { pattern = "g-paste", icon = "󰆒", color = "azure" },
      { pattern = "theme", icon = "󰏘", color = "yellow" },
      { pattern = "notes", icon = "󰎞", color = "yellow" },
      { pattern = "store", icon = "󰎞", color = "yellow" },
      { pattern = "copilot", icon = "󰚩", color = "cyan" },
      { pattern = "ai", icon = "󱙺", color = "purple" },
      { pattern = "project", icon = "󰉖", color = "blue" },
      { pattern = "dismiss", icon = "󰅖", color = "red" },
      { pattern = "notification", icon = "󰂚", color = "yellow" },
      { pattern = "notify", icon = "󰂚", color = "yellow" },
      { pattern = "info", icon = "󰋽", color = "blue" },
      { pattern = "warning", icon = "󰀪", color = "yellow" },
      { pattern = "error", icon = "󰅚", color = "red" },

      -- ========================================
      -- Nvim Built-in Modes & Operations
      -- ========================================
      { pattern = "visual", icon = "󰒉", color = "purple" },
      { pattern = "select", icon = "󰒆", color = "blue" },
      { pattern = "insert", icon = "󰌆", color = "green" },
      { pattern = "normal", icon = "󰆄", color = "blue" },
      { pattern = "replace", icon = "󰛔", color = "red" },
      { pattern = "command", icon = "󰞔", color = "yellow" },
      { pattern = "operator", icon = "󰅯", color = "orange" },
      { pattern = "motion", icon = "󰡬", color = "cyan" },
      { pattern = "indent", icon = "󰌒", color = "green" },
      { pattern = "indentation", icon = "󰌒", color = "green" },
      { pattern = "align", icon = "󰌆", color = "blue" },
      { pattern = "sort", icon = "󰕈", color = "yellow" },
      { pattern = "filter", icon = "󰈲", color = "purple" },
      { pattern = "macro", icon = "󰇗", color = "orange" },
      { pattern = "record", icon = "󰑊", color = "red" },
      { pattern = "register", icon = "󰅌", color = "yellow" },
      { pattern = "yank", icon = "󰆏", color = "azure" },
      { pattern = "put", icon = "󰆒", color = "azure" },
      { pattern = "delete", icon = "󰩺", color = "red" },
      { pattern = "change", icon = "󰏫", color = "orange" },
      { pattern = "join", icon = "󰌨", color = "blue" },
      { pattern = "split line", icon = "󰌪", color = "blue" },
      { pattern = "toggle", icon = "󰔠", color = "cyan" },
      { pattern = "switch", icon = "󰔢", color = "cyan" },
      { pattern = "uppercase", icon = "󰬷", color = "yellow" },
      { pattern = "lowercase", icon = "󰬶", color = "yellow" },
      { pattern = "increment", icon = "󰐊", color = "green" },
      { pattern = "decrement", icon = "󰐔", color = "red" },
      { pattern = "pick", icon = "󰒆", color = "blue" },
      { pattern = "add", icon = "󰐕", color = "green" },
      { pattern = "append", icon = "󰐕", color = "green" },
      { pattern = "reload", icon = "󰑓", color = "cyan" },
      { pattern = "refresh", icon = "󰑓", color = "cyan" },
      { pattern = "upgrade", icon = "󰚰", color = "green" },
      { pattern = "update", icon = "󰚰", color = "green" },
      { pattern = "enable", icon = "󰔫", color = "green" },
      { pattern = "disable", icon = "󰔯", color = "red" },
      { pattern = "cancel", icon = "󰜺", color = "red" },
      { pattern = "confirm", icon = "󰄬", color = "green" },
      { pattern = "accept", icon = "󰄬", color = "green" },
      { pattern = "show", icon = "󰈈", color = "yellow" },
      { pattern = "new", icon = "󰎔", color = "green" },
      { pattern = "create", icon = "󰎔", color = "green" },
    },
  },

  -- Group definitions for leader key prefixes
  spec = {
    -- ========================================
    -- Screen scroll & Cursor position (built-in)
    -- ========================================
    { "zt", desc = "Cursor to Top", icon = { icon = "󰁝", color = "blue" } },
    { "zz", desc = "Cursor to Center", icon = { icon = "󰡌", color = "blue" } },
    { "zb", desc = "Cursor to Bottom", icon = { icon = "󰁅", color = "blue" } },
    { "zs", desc = "Scroll Left", icon = { icon = "󰁍", color = "cyan" } },
    { "ze", desc = "Scroll Right", icon = { icon = "󰁔", color = "cyan" } },
    -- z series variants (with column alignment)
    { "z<CR>", desc = "Top this Line", icon = { icon = "󰁝", color = "blue" } },
    { "z+", desc = "Top this Line", icon = { icon = "󰁝", color = "blue" } },
    { "z^", desc = "First Non-Blank", icon = { icon = "󰘥", color = "grey" } },
    { "z-", desc = "Bottom this Line", icon = { icon = "󰁅", color = "blue" } },
    { "z.", desc = "Center this Line", icon = { icon = "󰡌", color = "blue" } },
    { "z=", desc = "Spelling Suggestions", icon = { icon = "󰓆", color = "yellow" } },

    -- ========================================
    -- Cursor navigation on screen (built-in)
    -- ========================================
    { "H", desc = "To Top of Screen", icon = { icon = "󰁝", color = "blue" } },
    { "M", desc = "To Middle of Screen", icon = { icon = "󰡌", color = "blue" } },
    { "L", desc = "To Bottom of Screen", icon = { icon = "󰁅", color = "blue" } },

    -- ========================================
    -- Line navigation (built-in)
    -- ========================================
    { "gg", desc = "Go to First Line", icon = { icon = "󰕮", color = "yellow" } },
    { "G", desc = "Go to Last Line", icon = { icon = "󰕱", color = "yellow" } },
    { "0", desc = "Start of Line", icon = { icon = "󰘥", color = "cyan" } },
    { "^", desc = "First Non-Blank", icon = { icon = "󰘥", color = "cyan" } },
    { "$", desc = "End of Line", icon = { icon = "󰘦", color = "cyan" } },

    -- ========================================
    -- Text editing (built-in)
    -- ========================================
    { "J", desc = "Join Lines", icon = { icon = "󰌨", color = "blue" } },
    { "gJ", desc = "Join Without Space", icon = { icon = "󰌨", color = "blue" } },
    { ">", desc = "Indent Right", icon = { icon = "󰌒", color = "green" } },
    { "<", desc = "Indent Left", icon = { icon = "󰌐", color = "green" } },
    { "=", desc = "Auto Indent", icon = { icon = "󰉼", color = "green" } },
    { "~", desc = "Toggle Case", icon = { icon = "󰬷", color = "yellow" } },
    { "gu", desc = "Lowercase", icon = { icon = "󰬶", color = "yellow" } },
    { "gU", desc = "Uppercase", icon = { icon = "󰬷", color = "yellow" } },

    -- ========================================
    -- Delete/Yank/Change (built-in)
    -- ========================================
    { "dd", desc = "Delete Line", icon = { icon = "󰩺", color = "red" } },
    { "D", desc = "Delete to End", icon = { icon = "󰩺", color = "red" } },
    { "yy", desc = "Yank Line", icon = { icon = "󰆏", color = "azure" } },
    { "Y", desc = "Yank to End", icon = { icon = "󰆏", color = "azure" } },
    { "cc", desc = "Change Line", icon = { icon = "󰏫", color = "orange" } },
    { "C", desc = "Change to End", icon = { icon = "󰏫", color = "orange" } },
    { "x", desc = "Delete Character", icon = { icon = "󰩺", color = "red" } },
    { "X", desc = "Delete Backward", icon = { icon = "󰩺", color = "red" } },
    { "s", desc = "Substitute Char", icon = { icon = "󰏫", color = "orange" } },
    { "S", desc = "Substitute Line", icon = { icon = "󰏫", color = "orange" } },

    -- ========================================
    -- Paste (built-in)
    -- ========================================
    { "p", desc = "Paste After", icon = { icon = "󰆒", color = "azure" } },
    { "P", desc = "Paste Before", icon = { icon = "󰅑", color = "azure" } },
    { "gp", desc = "Paste & Move After", icon = { icon = "󰆒", color = "azure" } },
    { "gP", desc = "Paste & Move Before", icon = { icon = "󰅑", color = "azure" } },

    -- ========================================
    -- Undo/Redo (built-in)
    -- ========================================
    { "u", desc = "Undo", icon = { icon = "󰕌", color = "yellow" } },
    { "U", desc = "Undo Line", icon = { icon = "󰕌", color = "yellow" } },
    { "<C-r>", desc = "Redo", icon = { icon = "󰑑", color = "orange" } },

    -- ========================================
    -- Insert mode (built-in)
    -- ========================================
    { "i", desc = "Insert Mode", icon = { icon = "󰌆", color = "green" } },
    { "I", desc = "Insert at Start", icon = { icon = "󰌆", color = "green" } },
    { "a", desc = "Append", icon = { icon = "󰐕", color = "green" } },
    { "A", desc = "Append at End", icon = { icon = "󰐕", color = "green" } },
    { "o", desc = "Open Below", icon = { icon = "󰌃", color = "blue" } },
    { "O", desc = "Open Above", icon = { icon = "󰌃", color = "blue" } },

    -- ========================================
    -- Search (built-in)
    -- ========================================
    { "*", desc = "Search Word Forward", icon = { icon = "󰗧", color = "yellow" } },
    { "#", desc = "Search Word Backward", icon = { icon = "󰗧", color = "yellow" } },
    { "n", desc = "Next Match", icon = { icon = "󰒭", color = "green" } },
    { "N", desc = "Prev Match", icon = { icon = "󰒮", color = "green" } },
    { ".", desc = "Repeat Last Change", icon = { icon = "󰑙", color = "orange" } },
    { "&", desc = "Repeat Substitute", icon = { icon = "󰛔", color = "orange" } },

    -- ========================================
    -- Visual mode (built-in)
    -- ========================================
    { "v", desc = "Visual Mode", icon = { icon = "󰒉", color = "purple" } },
    { "V", desc = "Visual Line", icon = { icon = "󰒉", color = "purple" } },
    { "<C-v>", desc = "Visual Block", icon = { icon = "󰒉", color = "purple" } },

    -- ========================================
    -- Replace mode (built-in)
    -- ========================================
    { "r", desc = "Replace Char", icon = { icon = "󰛔", color = "red" } },
    { "R", desc = "Replace Mode", icon = { icon = "󰛔", color = "red" } },

    -- ========================================
    -- Window commands (built-in)
    -- ========================================
    { "<C-w>h", desc = "Go Left Window", icon = { icon = "󰁍", color = "cyan" } },
    { "<C-w>j", desc = "Go Down Window", icon = { icon = "󰁅", color = "cyan" } },
    { "<C-w>k", desc = "Go Up Window", icon = { icon = "󰁝", color = "cyan" } },
    { "<C-w>l", desc = "Go Right Window", icon = { icon = "󰁔", color = "cyan" } },
    { "<C-w>w", desc = "Next Window", icon = { icon = "󰖲", color = "blue" } },
    { "<C-w>W", desc = "Prev Window", icon = { icon = "󰖲", color = "blue" } },
    { "<C-w>c", desc = "Close Window", icon = { icon = "󰖭", color = "red" } },
    { "<C-w>o", desc = "Only Window", icon = { icon = "󰖲", color = "blue" } },
    { "<C-w>s", desc = "Split Horizontal", icon = { icon = "󰤻", color = "cyan" } },
    { "<C-w>v", desc = "Split Vertical", icon = { icon = "󰤼", color = "cyan" } },
    { "<C-w>=", desc = "Equal Windows", icon = { icon = "󰕭", color = "green" } },

    -- ========================================
    -- Jump list (built-in)
    -- ========================================
    { "<C-o>", desc = "Jump Back", icon = { icon = "󰕍", color = "purple" } },
    { "<C-i>", desc = "Jump Forward", icon = { icon = "󰒭", color = "purple" } },

    -- ========================================
    -- Word movement (built-in)
    -- ========================================
    { "w", desc = "Word Forward", icon = { icon = "󰘂", color = "cyan" } },
    { "W", desc = "WORD Forward", icon = { icon = "󰘂", color = "cyan" } },
    { "b", desc = "Word Backward", icon = { icon = "󰘃", color = "cyan" } },
    { "B", desc = "WORD Backward", icon = { icon = "󰘃", color = "cyan" } },
    { "e", desc = "End of Word", icon = { icon = "󰘦", color = "cyan" } },
    { "E", desc = "End of WORD", icon = { icon = "󰘦", color = "cyan" } },
    { "ge", desc = "Prev Word End", icon = { icon = "󰘦", color = "cyan" } },
    { "gE", desc = "Prev WORD End", icon = { icon = "󰘦", color = "cyan" } },

    -- ========================================
    -- Character find (built-in)
    -- ========================================
    { "f", desc = "Find Char Forward", icon = { icon = "󰮗", color = "yellow" } },
    { "F", desc = "Find Char Backward", icon = { icon = "󰮗", color = "yellow" } },
    { "t", desc = "Till Char Forward", icon = { icon = "󰮗", color = "yellow" } },
    { "T", desc = "Till Char Backward", icon = { icon = "󰮗", color = "yellow" } },
    { ";", desc = "Repeat Find", icon = { icon = "󰑙", color = "orange" } },
    { ",", desc = "Repeat Find Reverse", icon = { icon = "󰕌", color = "yellow" } },

    -- ========================================
    -- Scrolling (built-in)
    -- ========================================
    { "<C-f>", desc = "Page Down", icon = { icon = "󰶡", color = "cyan" } },
    { "<C-b>", desc = "Page Up", icon = { icon = "󰶣", color = "cyan" } },
    { "<C-d>", desc = "Half Page Down", icon = { icon = "󰶡", color = "blue" } },
    { "<C-u>", desc = "Half Page Up", icon = { icon = "󰶣", color = "blue" } },
    { "<C-y>", desc = "Scroll Up", icon = { icon = "󰁝", color = "blue" } },
    { "<C-e>", desc = "Scroll Down", icon = { icon = "󰁅", color = "blue" } },

    -- ========================================
    -- Bracket matching (built-in)
    -- ========================================
    { "%", desc = "Match Bracket", icon = { icon = "󰅪", color = "orange" } },

    -- ========================================
    -- Jump to special positions (built-in)
    -- ========================================
    { "gD", desc = "Go to Declaration", icon = { icon = "󰙴", color = "blue" } },
    { "gi", desc = "Find Implementations", icon = { icon = "󰆧", color = "cyan" } },
    { "gl", desc = "Line Diagnostics", icon = { icon = "󰁨", color = "red" } },
    { "g;", desc = "Last Edit Position", icon = { icon = "󰕌", color = "yellow" } },
    { "g,", desc = "Next Edit Position", icon = { icon = "󰒭", color = "yellow" } },
    { "gv", desc = "Reselect Last Selection", icon = { icon = "󰒉", color = "purple" } },

    -- ========================================
    -- Folding (built-in)
    -- ========================================
    { "za", desc = "Toggle Fold", icon = { icon = "󰔡", color = "cyan" } },
    { "zo", desc = "Open Fold", icon = { icon = "󰁌", color = "blue" } },
    { "zc", desc = "Close Fold", icon = { icon = "󰁂", color = "purple" } },
    { "zr", desc = "Reduce Folds", icon = { icon = "󰁌", color = "blue" } },
    { "zm", desc = "More Folds", icon = { icon = "󰁂", color = "purple" } },
    { "zR", desc = "Open All Folds", icon = { icon = "󰁌", color = "blue" } },
    { "zM", desc = "Close All Folds", icon = { icon = "󰁂", color = "purple" } },
    { "zj", desc = "Next Fold", icon = { icon = "󰒭", color = "blue" } },
    { "zk", desc = "Prev Fold", icon = { icon = "󰒮", color = "blue" } },
    { "zv", desc = "View Cursor Line", icon = { icon = "󰈈", color = "yellow" } },
    { "zx", desc = "Reset Folds", icon = { icon = "󰜉", color = "orange" } },
    { "zX", desc = "Reset Folds Force", icon = { icon = "󰜉", color = "red" } },

    -- ========================================
    -- Marks (built-in)
    -- ========================================
    { "m", desc = "Set Mark", icon = { icon = "󰈻", color = "yellow" } },
    { "'", desc = "Go to Mark Line", icon = { icon = "󰕍", color = "yellow" } },
    { "`", desc = "Go to Mark Position", icon = { icon = "󰆾", color = "yellow" } },

    -- ========================================
    -- Macros (built-in)
    -- ========================================
    { "q", desc = "Record Macro", icon = { icon = "󰑊", color = "orange" } },
    { "@", desc = "Play Macro", icon = { icon = "󰇗", color = "orange" } },
    { "@@", desc = "Repeat Macro", icon = { icon = "󰇗", color = "cyan" } },

    { "<leader>s", group = "Split/Window", icon = { icon = "󰖲", color = "cyan" } },
    { "<leader>x", group = "Trouble/Diagnostics", icon = { icon = "󰁨", color = "red" } },
    { "<leader>w", group = "Window Jump", icon = { icon = "󰁝", color = "blue" } },
    { "<leader>t", group = "Tab/Tree/Terminal", icon = { icon = "󰓫", color = "blue" } },
    { "<leader>b", group = "Buffer", icon = { icon = "󰓩", color = "blue" } },
    { "<leader>g", group = "Git", icon = { icon = "󰊢", color = "purple" } },
    { "<leader>gb", group = "Git Blame", icon = { icon = "󰈀", color = "grey" } },
    { "<leader>r", group = "Replace/Rename", icon = { icon = "󰛔", color = "orange" } },
    { "<leader>c", group = "Code/Crates", icon = { icon = "󰏖", color = "yellow" } },
    { "<leader>co", group = "Color", icon = { icon = "󰏘", color = "yellow" } },
    { "<leader>n", group = "Harpoon/Navigation", icon = { icon = "󱋡", color = "purple" } },
    { "<leader>nb", desc = "Symbol Navigation (Aerial Float)", icon = { icon = "󰧮", color = "purple" } },
    { "<leader>no", desc = "Symbol Outline (Aerial)", icon = { icon = "󰯈", color = "purple" } },
    { "<leader>m", group = "Multicursor", icon = { icon = "󰇀", color = "cyan" } },
    { "<leader>a", desc = "Swap Next Parameter", icon = { icon = "󰓡", color = "blue" } },
    { "<leader>A", desc = "Swap Prev Parameter", icon = { icon = "󰓢", color = "blue" } },
    { "-", desc = "Open Parent Dir (Oil)", icon = { icon = "󰉖", color = "blue" } },
    { "<leader>-", desc = "Oil Float", icon = { icon = "󰉖", color = "blue" } },
    { "<leader>;", desc = "Dashboard", icon = { icon = "󰕮", color = "blue" } },
    { "<leader><leader>", group = "Telescope", icon = { icon = "󰭎", color = "blue" } },
    { "gp", group = "LSP Peek", icon = { icon = "󰈈", color = "yellow" } },
    { "gpd", desc = "Peek Definition", icon = { icon = "󰈮", color = "blue" } },
    { "gpi", desc = "Peek Implementation", icon = { icon = "󰆧", color = "cyan" } },
    { "gpr", desc = "Peek References", icon = { icon = "󰆽", color = "yellow" } },
    { "gpt", desc = "Peek Type Definition", icon = { icon = "󰜢", color = "cyan" } },
    { "g", group = "Go to", icon = { icon = "󰁔", color = "cyan" } },
    { "gd", desc = "Go to Definition", icon = { icon = "󰈮", color = "blue" } },
    { "gh", desc = "Hover Doc", icon = { icon = "󰋽", color = "blue" } },
    { "gy", desc = "Type Definition", icon = { icon = "󰜢", color = "cyan" } },
    { "gs", desc = "Signature Help", icon = { icon = "󰋽", color = "yellow" } },
    { "gj", desc = "Next Diagnostic", icon = { icon = "󰒭", color = "blue" } },
    { "gk", desc = "Prev Diagnostic", icon = { icon = "󰒮", color = "blue" } },
    -- Additional groups
    { "<leader>u", group = "UI Toggle", icon = { icon = "󰔡", color = "cyan" } },
    { "<leader>cp", desc = "Color Pick", icon = { icon = "󰏘", color = "yellow" } },
    { "<leader>cj", desc = "Toggle Split/Join", icon = { icon = "󰯋", color = "green" } },
    { "<leader>cs", desc = "Run Snippet", icon = { icon = "󰜎", color = "green" } },
    { "<leader>cl", desc = "CodeLens Run", icon = { icon = "󰜎", color = "green" } },
    { "<leader>ca", desc = "Code Action", icon = { icon = "󰅗", color = "green" } },
    { "<leader>rn", desc = "Rename Symbol", icon = { icon = "󰑕", color = "orange" } },
    { "<leader>rp", desc = "Project Search Replace", icon = { icon = "󰛔", color = "orange" } },
    { "<leader>rf", desc = "Replace in File", icon = { icon = "󰛔", color = "orange" } },
    { "<leader>rw", desc = "Search Word Replace", icon = { icon = "󰗧", color = "orange" } },
    { "<leader>gds", desc = "Document Symbols", icon = { icon = "󰧮", color = "purple" } },
    { "<leader>ws", desc = "Workspace Symbols", icon = { icon = "󱃖", color = "blue" } },
    { "<leader>d", group = "Document/Scroll", icon = { icon = "󰧮", color = "purple" } },
    { "<leader>o", desc = "Go Back", icon = { icon = "󰕍", color = "purple" } },
    { "<leader>i", desc = "Go Forward", icon = { icon = "󰒭", color = "purple" } },
    { "<leader>k", desc = "Clear Search Highlight", icon = { icon = "󰹊", color = "grey" } },
    { "<leader>p", desc = "Paste from Clipboard", icon = { icon = "󰆒", color = "azure" } },
    { "<leader>y", desc = "Copy to Clipboard", icon = { icon = "󰆏", color = "azure" } },
    { "<leader>gt", group = "Git Toggle", icon = { icon = "󰔡", color = "cyan" } },
    { "<leader>f", group = "Find", icon = { icon = "󰭎", color = "blue" } },
    { "<leader>h", desc = "Prev Tab", icon = { icon = "󰒮", color = "blue" } },
    { "<leader>l", desc = "Next Tab", icon = { icon = "󰒭", color = "blue" } },

    -- ========================================
    -- Telescope find keys
    -- ========================================
    { "<leader>ff", desc = "Find Files", icon = { icon = "󰈞", color = "blue" } },
    { "<leader>fg", desc = "Live Grep", icon = { icon = "󱎸", color = "yellow" } },
    { "<leader>fp", desc = "Projects", icon = { icon = "󰉖", color = "blue" } },
    { "<leader>fc", desc = "Colorscheme", icon = { icon = "󰏘", color = "yellow" } },
    { "<leader>fe", desc = "File Browser", icon = { icon = "󰉖", color = "blue" } },
    { "<leader>fk", desc = "Keymaps", icon = { icon = "󰌌", color = "yellow" } },
    { "<leader>fb", desc = "Buffers", icon = { icon = "󰓩", color = "blue" } },
    { "<leader>fj", desc = "Flash Jump", icon = { icon = "󱐋", color = "yellow" } },
    { "<leader>fS", desc = "Flash Treesitter", icon = { icon = "󰐅", color = "green" } },
    { "<leader>fy", desc = "Yank History", icon = { icon = "󰋚", color = "yellow" } },
    { "<leader>ft", desc = "Search TODOs", icon = { icon = "󰸞", color = "yellow" } },
    { "<leader>fT", desc = "Search FIXMEs", icon = { icon = "󰅚", color = "red" } },

    -- ========================================
    -- Terminal keys
    -- ========================================
    { "<leader>tf", desc = "Float Terminal", icon = { icon = "󰀻", color = "green" } },
    { "<leader>tr", desc = "Right Terminal", icon = { icon = "󰁔", color = "green" } },
    { "<leader>td", desc = "Bottom Terminal", icon = { icon = "󰘯", color = "green" } },
    { "<leader>tp", desc = "Pick Tab", icon = { icon = "�", color = "blue" } },
    { "<leader>tc", desc = "Close Tab", icon = { icon = "󰅖", color = "red" } },
    { "<leader>tt", desc = "File Tree", icon = { icon = "󱏒", color = "green" } },

    -- ========================================
    -- Git keys
    -- ========================================
    { "<leader>gg", desc = "Open Neogit", icon = { icon = "󰊢", color = "green" } },
    { "<leader>gj", desc = "Next Hunk", icon = { icon = "�󰒭", color = "blue" } },
    { "<leader>gk", desc = "Prev Hunk", icon = { icon = "󰒮", color = "blue" } },
    { "<leader>gs", desc = "Stage Hunk", icon = { icon = "󰅰", color = "green" } },
    { "<leader>gS", desc = "Stage Buffer", icon = { icon = "󰅰", color = "green" } },
    { "<leader>gu", desc = "Undo Stage Hunk", icon = { icon = "󰕌", color = "yellow" } },
    { "<leader>gr", desc = "Reset Hunk", icon = { icon = "󰜉", color = "red" } },
    { "<leader>gR", desc = "Reset Buffer", icon = { icon = "󰜉", color = "red" } },
    { "<leader>gp", desc = "Preview Hunk", icon = { icon = "󰈈", color = "yellow" } },
    { "<leader>gd", desc = "Diff This", icon = { icon = "󰦫", color = "cyan" } },
    { "<leader>gD", desc = "Diff All", icon = { icon = "󰦫", color = "cyan" } },

    -- ========================================
    -- Buffer keys
    -- ========================================
    { "<leader>bd", desc = "Delete Buffer", icon = { icon = "󰅖", color = "red" } },
    { "<leader>bo", desc = "Delete Other Buffers", icon = { icon = "󰗨", color = "red" } },
    { "<leader>bc", desc = "Pick Close Tab", icon = { icon = "󰓾", color = "red" } },

    -- ========================================
    -- Trouble keys
    -- ========================================
    { "<leader>xx", desc = "Trouble Toggle", icon = { icon = "󰁨", color = "red" } },
    { "<leader>xd", desc = "Diagnostics", icon = { icon = "󰁨", color = "red" } },
    { "<leader>xs", desc = "Document Symbols", icon = { icon = "󰧮", color = "purple" } },
    { "<leader>xr", desc = "LSP References", icon = { icon = "󰆽", color = "yellow" } },
    { "<leader>xl", desc = "Location List", icon = { icon = "󰷐", color = "blue" } },
    { "<leader>xq", desc = "Quickfix", icon = { icon = "󰷐", color = "blue" } },

    -- ========================================
    -- Harpoon keys
    -- ========================================
    { "<leader>na", desc = "Harpoon Add", icon = { icon = "󰐕", color = "green" } },
    { "<leader>nt", desc = "Harpoon Toggler", icon = { icon = "󱋡", color = "blue" } },
    { "<leader>nn", desc = "Harpoon Next", icon = { icon = "󰁔", color = "blue" } },
    { "<leader>np", desc = "Harpoon Prev", icon = { icon = "󰁍", color = "blue" } },
    { "<leader>ng", desc = "Harpoon Telescope", icon = { icon = "󰭎", color = "blue" } },
    { "<leader>n1", desc = "Harpoon File 1", icon = { icon = "󰓾", color = "blue" } },
    { "<leader>n2", desc = "Harpoon File 2", icon = { icon = "󰓾", color = "blue" } },
    { "<leader>n3", desc = "Harpoon File 3", icon = { icon = "󰓾", color = "blue" } },
    { "<leader>n4", desc = "Harpoon File 4", icon = { icon = "󰓾", color = "blue" } },
    { "<leader>n5", desc = "Harpoon File 5", icon = { icon = "󰓾", color = "blue" } },
    { "<leader>n6", desc = "Harpoon File 6", icon = { icon = "󰓾", color = "blue" } },

    -- ========================================
    -- Window/Split keys
    -- ========================================
    { "<leader>sv", desc = "Split Vertical", icon = { icon = "󰤼", color = "cyan" } },
    { "<leader>sh", desc = "Split Horizontal", icon = { icon = "󰤻", color = "cyan" } },
    { "<leader>sc", desc = "Close Window", icon = { icon = "󰖭", color = "red" } },
    { "<leader>so", desc = "Close Other Windows", icon = { icon = "󰗨", color = "red" } },
    { "<leader>s=", desc = "Equal Windows", icon = { icon = "󰕭", color = "green" } },

    -- ========================================
    -- Dial (Value increment/decrement)
    -- ========================================
    { "<leader>v", group = "Value (Dial)", icon = { icon = "󰐊", color = "green" } },
    { "<leader>va", desc = "Dial Increment", icon = { icon = "󰐊", color = "green" } },
    { "<leader>vx", desc = "Dial Decrement", icon = { icon = "󰐔", color = "red" } },
    { "<leader>vA", desc = "Dial Increment (global)", icon = { icon = "󰐊", color = "green" } },
    { "<leader>vX", desc = "Dial Decrement (global)", icon = { icon = "󰐔", color = "red" } },
  },
})

end

return M
