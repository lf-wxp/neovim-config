local status, which_key = pcall(require, "which-key")
if not status then
  vim.notify("which-key not found")
  return
end

which_key.setup({
  icons = {
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
      { pattern = "window width", icon = "󰩨", color = "green" },
      { pattern = "window height", icon = "󰩩", color = "green" },
      { pattern = "equal windows", icon = "󰕭", color = "green" },
      { pattern = "windows", icon = "󰖲", color = "cyan" },
      { pattern = "split", icon = "󰘶", color = "cyan" },
      { pattern = "window", icon = "󰖲", color = "cyan" },

      -- ========================================
      -- Navigation
      -- ========================================
      { pattern = "file tree", icon = "󱏒", color = "green" },
      { pattern = "tree", icon = "󱏒", color = "green" },
      { pattern = "open parent dir", icon = "󰁝", color = "cyan" },
      { pattern = "oil float", icon = "󰉖", color = "azure" },
      { pattern = "navigate forward", icon = "󰒭", color = "purple" },
      { pattern = "navigate backward", icon = "󰕍", color = "purple" },
      { pattern = "go back", icon = "󰕍", color = "purple" },
      { pattern = "go forward", icon = "󰒭", color = "purple" },
      { pattern = "jump", icon = "󰆾", color = "purple" },
      { pattern = "scroll up", icon = "󰶣", color = "cyan" },
      { pattern = "scroll down", icon = "󰶡", color = "cyan" },
      { pattern = "dashboard", icon = "󰕮", color = "blue" },
      { pattern = "next", icon = "󰒭", color = "blue" },
      { pattern = "prev", icon = "󰒮", color = "blue" },
      { pattern = "list", icon = "󰷐", color = "cyan" },
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
      { pattern = "move selection", icon = "󰜴", color = "purple" },
      { pattern = "surround", icon = "󰅪", color = "orange" },
      { pattern = "paste from clipboard", icon = "󰆒", color = "azure" },
      { pattern = "copy to clipboard", icon = "󰆏", color = "azure" },
      { pattern = "paste", icon = "󰆒", color = "azure" },
      { pattern = "copy", icon = "󰆏", color = "azure" },
      { pattern = "yank", icon = "󰆏", color = "azure" },
      { pattern = "clear search highlight", icon = "󰹊", color = "grey" },
      { pattern = "highlight", icon = "󰸱", color = "azure" },
      { pattern = "rename", icon = "󰑕", color = "green" },
      { pattern = "replace in file", icon = "󰛔", color = "orange" },
      { pattern = "project search replace", icon = "󰛔", color = "orange" },
      { pattern = "search word", icon = "󰗧", color = "yellow" },
      { pattern = "replace", icon = "󰲢", color = "orange" },
      { pattern = "format", icon = "󰉼", color = "green" },
      { pattern = "edit", icon = "󰔨", color = "blue" },
      { pattern = "select", icon = "󰒆", color = "purple" },
      { pattern = "toggle split/join", icon = "󰯋", color = "green" },

      -- ========================================
      -- Text Objects
      -- ========================================
      { pattern = "inside", icon = "󰟵", color = "cyan" },
      { pattern = "around", icon = "󰟶", color = "cyan" },
      { pattern = "inner", icon = "󰟵", color = "cyan" },

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
      { pattern = "move tab left", icon = "󰜱", color = "purple" },
      { pattern = "move tab right", icon = "󰜴", color = "purple" },
      { pattern = "pick tab", icon = "󰓾", color = "green" },
      { pattern = "buffer", icon = "󰓩", color = "blue" },
      { pattern = "buffers", icon = "󰓩", color = "blue" },
      { pattern = "tab", icon = "󰓫", color = "blue" },

      -- ========================================
      -- Search & Telescope
      -- ========================================
      { pattern = "find files", icon = "󰈞", color = "blue" },
      { pattern = "live grep", icon = "󱎸", color = "yellow" },
      { pattern = "projects", icon = "󰉖", color = "blue" },
      { pattern = "colorscheme", icon = "󰏘", color = "purple" },
      { pattern = "file browser", icon = "󰉖", color = "cyan" },
      { pattern = "keymaps", icon = "󰌌", color = "yellow" },
      { pattern = "telescope", icon = "󰭎", color = "blue" },
      { pattern = "find", icon = "󰮗", color = "blue" },
      { pattern = "grep", icon = "󱎸", color = "yellow" },
      { pattern = "search", icon = "󰍉", color = "yellow" },

      -- ========================================
      -- Git
      -- ========================================
      { pattern = "open neogit", icon = "󰊢", color = "orange" },
      { pattern = "neogit", icon = "󰊢", color = "orange" },
      { pattern = "lazygit", icon = "󰊢", color = "green" },
      { pattern = "next hunk", icon = "󰒭", color = "blue" },
      { pattern = "prev hunk", icon = "󰒮", color = "blue" },
      { pattern = "stage hunk", icon = "󰅰", color = "green" },
      { pattern = "stage buffer", icon = "󰅰", color = "green" },
      { pattern = "undo stage", icon = "󰕌", color = "orange" },
      { pattern = "reset hunk", icon = "󰜉", color = "red" },
      { pattern = "reset buffer", icon = "󰜉", color = "red" },
      { pattern = "preview hunk", icon = "󰈈", color = "yellow" },
      { pattern = "blame line", icon = "󰈀", color = "grey" },
      { pattern = "diff this", icon = "󰦫", color = "orange" },
      { pattern = "diff all", icon = "󰦫", color = "orange" },
      { pattern = "toggle deleted", icon = "󰔡", color = "cyan" },
      { pattern = "toggle line blame", icon = "󰔡", color = "cyan" },
      { pattern = "select hunk", icon = "󰒆", color = "purple" },
      { pattern = "git", icon = "󰊢", color = "purple" },
      { pattern = "diff", icon = "󰦫", color = "orange" },
      { pattern = "stage", icon = "󰅰", color = "green" },
      { pattern = "hunk", icon = "󰠖", color = "yellow" },
      { pattern = "blame", icon = "󰈀", color = "grey" },
      { pattern = "reset", icon = "󰜉", color = "red" },

      -- ========================================
      -- Harpoon
      -- ========================================
      { pattern = "harpoon add", icon = "󰐕", color = "green" },
      { pattern = "harpoon toggler", icon = "󱋡", color = "purple" },
      { pattern = "open harpoon", icon = "󱋡", color = "purple" },
      { pattern = "harpoon prev", icon = "󰁍", color = "blue" },
      { pattern = "harpoon next", icon = "󰁔", color = "blue" },
      { pattern = "harpoon file", icon = "󰓾", color = "cyan" },
      { pattern = "harpoon", icon = "󱋡", color = "purple" },

      -- ========================================
      -- Terminal
      -- ========================================
      { pattern = "float terminal", icon = "󰀻", color = "green" },
      { pattern = "right terminal", icon = "󰁔", color = "green" },
      { pattern = "bottom terminal", icon = "󰘯", color = "green" },
      { pattern = "terminal", icon = "󰆍", color = "white" },
      { pattern = "toggle", icon = "󰔠", color = "cyan" },

      -- ========================================
      -- LSP
      -- ========================================
      { pattern = "go to definition", icon = "󰈮", color = "blue" },
      { pattern = "hover doc", icon = "󰋽", color = "blue" },
      { pattern = "peek declaration", icon = "󰙴", color = "blue" },
      { pattern = "peek definition", icon = "󰈮", color = "blue" },
      { pattern = "peek implementation", icon = "󰆧", color = "purple" },
      { pattern = "peek references", icon = "󰆽", color = "yellow" },
      { pattern = "peek type", icon = "󰜢", color = "cyan" },
      { pattern = "close preview", icon = "󰅖", color = "red" },
      { pattern = "find references", icon = "󰆽", color = "yellow" },
      { pattern = "line diagnostics", icon = "󰁨", color = "red" },
      { pattern = "next diagnostic", icon = "󰒭", color = "blue" },
      { pattern = "prev diagnostic", icon = "󰒮", color = "blue" },
      { pattern = "code action", icon = "󰅗", color = "green" },
      { pattern = "diagnostic", icon = "󰁨", color = "red" },
      { pattern = "definition", icon = "󰈮", color = "blue" },
      { pattern = "reference", icon = "󰆽", color = "yellow" },
      { pattern = "implementation", icon = "󰆧", color = "purple" },
      { pattern = "declaration", icon = "󰙴", color = "blue" },
      { pattern = "hover", icon = "󰋽", color = "blue" },
      { pattern = "lsp", icon = "󰒒", color = "purple" },
      { pattern = "preview", icon = "󰈈", color = "yellow" },

      -- ========================================
      -- Crates.nvim
      -- ========================================
      { pattern = "crate toggle", icon = "󰔡", color = "orange" },
      { pattern = "crate reload", icon = "󰑓", color = "cyan" },
      { pattern = "crate versions", icon = "󰦨", color = "blue" },
      { pattern = "crate features", icon = "󰃥", color = "yellow" },
      { pattern = "crate dependencies", icon = "󱃖", color = "orange" },
      { pattern = "crate update", icon = "󰚰", color = "green" },
      { pattern = "crate upgrade all", icon = "󰁝", color = "green" },
      { pattern = "crate upgrade", icon = "󰁝", color = "green" },
      { pattern = "crate homepage", icon = "󰖟", color = "blue" },
      { pattern = "crate repository", icon = "󰳐", color = "purple" },
      { pattern = "crate documentation", icon = "󰈙", color = "blue" },
      { pattern = "crate crates.io", icon = "󰆧", color = "cyan" },
      { plugin = "crates.nvim", pattern = "crate", icon = "󰏖", color = "purple" },

      -- ========================================
      -- Multicursor
      -- ========================================
      { pattern = "add cursor", icon = "�", color = "cyan" },
      { pattern = "skip cursor", icon = "�", color = "grey" },
      { pattern = "toggle cursor", icon = "󰔡", color = "cyan" },
      { pattern = "cursor", icon = "�", color = "cyan" },
      { pattern = "multiple", icon = "󰳽", color = "red" },

      -- ========================================
      -- Snacks & Dashboard
      -- ========================================
      { pattern = "dashboard", icon = "󰕮", color = "blue" },
      { pattern = "snacks", icon = "󱥁", color = "yellow" },

      -- ========================================
      -- Run & Debug
      -- ========================================
      { pattern = "run snippet", icon = "󰜎", color = "green" },
      { pattern = "sniprun", icon = "�", color = "green" },
      { pattern = "run", icon = "�", color = "green" },
      { pattern = "test", icon = "󰔱", color = "green" },
      { pattern = "debug", icon = "�", color = "red" },
      { pattern = "build", icon = "󱃖", color = "orange" },

      -- ========================================
      -- Comments
      -- ========================================
      { pattern = "comment", icon = "󰆉", color = "grey" },
      { pattern = "annotation", icon = "�", color = "grey" },
      { pattern = "todo", icon = "󰸞", color = "yellow" },

      -- ========================================
      -- Session & History
      -- ========================================
      { pattern = "session", icon = "󰖲", color = "blue" },
      { pattern = "undo", icon = "�", color = "yellow" },
      { pattern = "redo", icon = "�", color = "orange" },
      { pattern = "history", icon = "󰋚", color = "yellow" },
      { pattern = "bookmark", icon = "󰸃", color = "yellow" },
      { pattern = "mark", icon = "�", color = "yellow" },

      -- ========================================
      -- Tools & Package Manager
      -- ========================================
      { pattern = "lazy", icon = "�", color = "blue" },
      { pattern = "mason", icon = "󱌢", color = "yellow" },
      { pattern = "package", icon = "�", color = "yellow" },
      { pattern = "plugin", icon = "󰜪", color = "cyan" },
      { pattern = "setting", icon = "󰢻", color = "grey" },
      { pattern = "config", icon = "󰢻", color = "grey" },
      { pattern = "help", icon = "�", color = "blue" },
      { pattern = "command", icon = "󰞔", color = "grey" },

      -- ========================================
      -- File Operations
      -- ========================================
      { pattern = "file", icon = "�", color = "blue" },
      { pattern = "close", icon = "�", color = "red" },
      { pattern = "delete", icon = "�", color = "red" },
      { pattern = "save", icon = "�", color = "green" },
      { pattern = "open", icon = "󰝋", color = "green" },
      { pattern = "quit", icon = "�", color = "red" },
      { pattern = "oil", icon = "󰈚", color = "azure" },

      -- ========================================
      -- Fold & View
      -- ========================================
      { pattern = "fold", icon = "�", color = "purple" },
      { pattern = "unfold", icon = "�", color = "purple" },

      -- ========================================
      -- Misc
      -- ========================================
      { pattern = "color", icon = "󰏘", color = "yellow" },
      { pattern = "theme", icon = "󰏘", color = "yellow" },
      { pattern = "copilot", icon = "󰚩", color = "azure" },
      { pattern = "project", icon = "󰉖", color = "blue" },
      { pattern = "dismiss", icon = "󰅖", color = "red" },
      { pattern = "notification", icon = "󰂚", color = "yellow" },
      { pattern = "notify", icon = "󰂚", color = "yellow" },
      { pattern = "info", icon = "󰋽", color = "blue" },
      { pattern = "warning", icon = "󰀪", color = "yellow" },
      { pattern = "error", icon = "󰅚", color = "red" },

      -- ========================================
      -- Generic Actions
      -- ========================================
      { pattern = "pick", icon = "󰒆", color = "green" },
      { pattern = "add", icon = "󰐕", color = "green" },
      { pattern = "append", icon = "󰐕", color = "green" },
      { pattern = "reload", icon = "󰑓", color = "cyan" },
      { pattern = "refresh", icon = "�", color = "cyan" },
      { pattern = "upgrade", icon = "󰚰", color = "green" },
      { pattern = "update", icon = "�", color = "green" },
      { pattern = "enable", icon = "�", color = "green" },
      { pattern = "disable", icon = "�", color = "red" },
      { pattern = "cancel", icon = "�", color = "red" },
      { pattern = "confirm", icon = "�", color = "green" },
      { pattern = "accept", icon = "󰄬", color = "green" },
      { pattern = "show", icon = "󰈈", color = "yellow" },
      { pattern = "new", icon = "󰎔", color = "green" },
      { pattern = "create", icon = "󰎔", color = "green" },
    },
  },

  -- Group definitions for leader key prefixes
  spec = {
    { "<leader>s", group = "Split/Window", icon = "󰖲" },
    { "<leader>w", group = "Window Jump", icon = "󰁝" },
    { "<leader>t", group = "Tab/Tree", icon = "󰓫" },
    { "<leader>b", group = "Buffer", icon = "󰓩" },
    { "<leader>g", group = "Git", icon = "󰊢" },
    { "<leader>r", group = "Replace/Rename", icon = "󰛔" },
    { "<leader>c", group = "Crates/Code", icon = "󰏖" },
    { "<leader>n", group = "Harpoon", icon = "󱋡" },
    { "<leader>m", group = "Multicursor", icon = "󰇀" },
    { "<leader><leader>", group = "Telescope", icon = "󰭎" },
    { "gp", group = "LSP Peek", icon = "󰈈" },
    { "g", group = "Go to", icon = "�" },
  },
})
