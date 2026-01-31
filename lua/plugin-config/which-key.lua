local status, which_key = pcall(require, "which-key")
if not status then
  vim.notify("没有找到 which_key")
  return
end

which_key.setup({
  icons = {
    rules = {
      -- ========================================
      -- Navigation (导航)
      -- ========================================
      { pattern = "tree", icon = "󱏒", color = "green" },
      { pattern = "harpoon", icon = "󱋡", color = "purple" },
      { pattern = "navigate forward", icon = "󰒭", color = "purple" },
      { pattern = "navigate backward", icon = "󰕍", color = "purple" },
      { pattern = "jump", icon = "󰆾", color = "purple" },
      { pattern = "scroll up", icon = "󰶣", color = "cyan" },
      { pattern = "scroll down", icon = "󰶡", color = "cyan" },
      { pattern = "dashboard", icon = "󰕮", color = "blue" },
      { pattern = "next", icon = "󰒭", color = "blue" },
      { pattern = "prev", icon = "󰒮", color = "blue" },
      { pattern = "list", icon = "󰷐", color = "cyan" },
      { pattern = "outline", icon = "󰧮", color = "purple" },

      -- ========================================
      -- Flash (跳转)
      -- ========================================
      { pattern = "flash whole", icon = "󰉁", color = "yellow" },
      { pattern = "flash treesitter", icon = "󰐅", color = "green" },
      { pattern = "flash", icon = "󱐋", color = "yellow" },

      -- ========================================
      -- Editing (编辑)
      -- ========================================
      { pattern = "surround", icon = "󰅪", color = "orange" },
      { pattern = "paste", icon = "󰆒", color = "azure" },
      { pattern = "copy", icon = "󰆏", color = "azure" },
      { pattern = "yank", icon = "󰆏", color = "azure" },
      { pattern = "highlight", icon = "󰸱", color = "azure" },
      { pattern = "dismiss highlight", icon = "󰹊", color = "grey" },
      { pattern = "rename", icon = "󰑕", color = "green" },
      { pattern = "replace", icon = "󰲢", color = "orange" },
      { pattern = "format", icon = "󰉼", color = "green" },
      { pattern = "edit", icon = "󰔨", color = "blue" },
      { pattern = "select", icon = "󰒆", color = "purple" },
      { pattern = "visual move", icon = "󰜴", color = "purple" },
      { pattern = "split or join", icon = "󰯋", color = "green" },

      -- ========================================
      -- Buffer & Window (缓冲区和窗口)
      -- ========================================
      { pattern = "buffer", icon = "󰓩", color = "blue" },
      { pattern = "switch buffer", icon = "󰒺", color = "blue" },
      { pattern = "delete buffer", icon = "󰅖", color = "red" },
      { pattern = "delete other", icon = "󰗨", color = "red" },
      { pattern = "windows split vertical", icon = "󰤼", color = "cyan" },
      { pattern = "windows split horizontal", icon = "󰤻", color = "cyan" },
      { pattern = "windows close", icon = "󰖭", color = "red" },
      { pattern = "windows pop", icon = "󰁝", color = "cyan" },
      { pattern = "split", icon = "󰘶", color = "cyan" },
      { pattern = "window", icon = "󰖲", color = "cyan" },
      { pattern = "move", icon = "󰘕", color = "purple" },
      { pattern = "resize", icon = "󰙖", color = "green" },
      { pattern = "even", icon = "󰕭", color = "green" },

      -- ========================================
      -- Tab / Bufferline (标签页)
      -- ========================================
      { pattern = "tab left", icon = "󰁍", color = "blue" },
      { pattern = "tab right", icon = "󰁔", color = "blue" },
      { pattern = "tab move left", icon = "󰜱", color = "purple" },
      { pattern = "tab move right", icon = "󰜴", color = "purple" },
      { pattern = "tab pick", icon = "󰓾", color = "green" },
      { pattern = "tab close", icon = "󰅖", color = "red" },
      { pattern = "tab", icon = "󰓫", color = "blue" },

      -- ========================================
      -- File Operations (文件操作)
      -- ========================================
      { pattern = "file browser", icon = "󰉖", color = "cyan" },
      { pattern = "file", icon = "󰈚", color = "blue" },
      { pattern = "close", icon = "󰅖", color = "red" },
      { pattern = "delete", icon = "󰗨", color = "red" },
      { pattern = "save", icon = "󰆓", color = "green" },
      { pattern = "open parent", icon = "󰁝", color = "cyan" },
      { pattern = "open", icon = "󰝋", color = "green" },
      { pattern = "quit", icon = "󰈆", color = "red" },
      { pattern = "oil float", icon = "󰉖", color = "azure" },
      { pattern = "oil", icon = "󰈚", color = "azure" },

      -- ========================================
      -- Search & Telescope (搜索)
      -- ========================================
      { pattern = "search keymaps", icon = "󰌌", color = "yellow" },
      { pattern = "search text", icon = "󱎸", color = "yellow" },
      { pattern = "search", icon = "󰍉", color = "yellow" },
      { pattern = "find file", icon = "󰈞", color = "blue" },
      { pattern = "find project", icon = "󰉖", color = "blue" },
      { pattern = "find colorscheme", icon = "󰏘", color = "purple" },
      { pattern = "find session", icon = "󱂬", color = "blue" },
      { pattern = "telescope", icon = "󰭎", color = "blue" },
      { pattern = "find", icon = "󰮗", color = "blue" },
      { pattern = "grep", icon = "󱎸", color = "yellow" },

      -- ========================================
      -- Git (版本控制)
      -- ========================================
      { pattern = "neogit", icon = "󰊢", color = "orange" },
      { pattern = "lazygit", icon = "󰊢", color = "green" },
      { pattern = "git push", icon = "󰶮", color = "green" },
      { pattern = "git pull", icon = "󰶯", color = "blue" },
      { pattern = "git commit", icon = "󰜘", color = "green" },
      { pattern = "git branch", icon = "󰘬", color = "purple" },
      { pattern = "git", icon = "󰊢", color = "purple" },
      { pattern = "diff", icon = "󰦫", color = "orange" },
      { pattern = "stage", icon = "󰅰", color = "green" },
      { pattern = "unstage", icon = "󰅰", color = "orange" },
      { pattern = "hunk", icon = "󰠖", color = "yellow" },
      { pattern = "blame", icon = "󰈀", color = "grey" },
      { pattern = "restore", icon = "󰁯", color = "blue" },
      { pattern = "reset", icon = "󰜉", color = "red" },

      -- ========================================
      -- Toggle & UI (切换和界面)
      -- ========================================
      { pattern = "toggler", icon = "󰨚", color = "cyan" },
      { pattern = "toggle", icon = "󰔠", color = "cyan" },
      { pattern = "ui", icon = "󰕰", color = "cyan" },
      { pattern = "fold", icon = "󰅂", color = "purple" },

      -- ========================================
      -- Terminal (终端)
      -- ========================================
      { pattern = "toggle terminal", icon = "󰆍", color = "green" },
      { pattern = "terminal", icon = "󰆍", color = "white" },
      { pattern = "float", icon = "󰀻", color = "cyan" },
      { pattern = "bottom", icon = "󰘯", color = "cyan" },
      { pattern = "right", icon = "󰁔", color = "cyan" },
      { pattern = "switch", icon = "󰯙", color = "purple" },

      -- ========================================
      -- Runner & Debug (运行和调试)
      -- ========================================
      { pattern = "sniprun", icon = "󰜎", color = "green" },
      { pattern = "run", icon = "󰐥", color = "green" },
      { pattern = "test", icon = "󰔱", color = "green" },
      { pattern = "debug", icon = "󰃤", color = "red" },
      { pattern = "build", icon = "󱃖", color = "orange" },

      -- ========================================
      -- LSP (语言服务)
      -- ========================================
      { pattern = "preview definition", icon = "󰈮", color = "blue" },
      { pattern = "preview implementation", icon = "󰆧", color = "purple" },
      { pattern = "preview references", icon = "󰆽", color = "yellow" },
      { pattern = "preview type", icon = "󰜢", color = "cyan" },
      { pattern = "close preview", icon = "󰅖", color = "red" },
      { pattern = "preview", icon = "󰈈", color = "yellow" },
      { pattern = "code action", icon = "󰅗", color = "green" },
      { pattern = "codeaction", icon = "󰅗", color = "green" },
      { pattern = "hover", icon = "󰋽", color = "blue" },
      { pattern = "signature", icon = "󰷻", color = "purple" },
      { pattern = "workspace", icon = "�", color = "blue" },
      { pattern = "lsp", icon = "�󰒒", color = "purple" },
      { pattern = "diagnostic", icon = "󰁨", color = "red" },
      { pattern = "definition", icon = "󰈮", color = "blue" },
      { pattern = "reference", icon = "󰆽", color = "yellow" },
      { pattern = "implementation", icon = "󰆧", color = "purple" },
      { pattern = "declaration", icon = "󰙴", color = "blue" },

      -- ========================================
      -- Crates.nvim (Rust 包管理)
      -- ========================================
      { pattern = "crate toggle", icon = "󰔡", color = "orange" },
      { pattern = "crate reload", icon = "󰑓", color = "cyan" },
      { pattern = "crate version", icon = "󰦨", color = "blue" },
      { pattern = "crate features", icon = "󰃥", color = "yellow" },
      { pattern = "crate dependencies", icon = "󱃖", color = "orange" },
      { pattern = "crate update", icon = "󰚰", color = "green" },
      { pattern = "crate upgrade", icon = "󰁝", color = "green" },
      { pattern = "crate homepage", icon = "󰖟", color = "blue" },
      { pattern = "crate repository", icon = "󰳐", color = "purple" },
      { pattern = "crate document", icon = "󰈙", color = "blue" },
      { pattern = "crate open", icon = "󰆧", color = "cyan" },
      { plugin = "crates.nvim", pattern = "crate", icon = "󰏖", color = "purple" },

      -- ========================================
      -- Harpoon (快速跳转)
      -- ========================================
      { pattern = "harpoon append", icon = "󰐕", color = "green" },
      { pattern = "harpoon toggle", icon = "󱋡", color = "purple" },
      { pattern = "harpoon next", icon = "󰁔", color = "blue" },
      { pattern = "harpoon prev", icon = "󰁍", color = "blue" },

      -- ========================================
      -- Grug-Far (替换)
      -- ========================================
      { pattern = "find replace", icon = "󰛔", color = "orange" },
      { pattern = "find current word", icon = "󰗧", color = "yellow" },
      { pattern = "find current", icon = "󰈞", color = "blue" },

      -- ========================================
      -- Multicursor (多光标)
      -- ========================================
      { pattern = "cursor", icon = "󰇀", color = "cyan" },
      { pattern = "multiple", icon = "󰳽", color = "red" },

      -- ========================================
      -- Comments (注释)
      -- ========================================
      { pattern = "comment", icon = "󰆉", color = "grey" },
      { pattern = "annotation", icon = "󰎚", color = "grey" },
      { pattern = "todo", icon = "󰸞", color = "yellow" },

      -- ========================================
      -- Undo & History (撤销和历史)
      -- ========================================
      { pattern = "undo", icon = "󰆴", color = "yellow" },
      { pattern = "redo", icon = "󰆚", color = "orange" },
      { pattern = "session", icon = "󰖲", color = "blue" },
      { pattern = "bookmark", icon = "󰸃", color = "yellow" },
      { pattern = "mark", icon = "󰃃", color = "yellow" },
      { pattern = "history", icon = "󰋚", color = "yellow" },

      -- ========================================
      -- Tools & Misc (工具和杂项)
      -- ========================================
      { pattern = "lazy", icon = "󰒲", color = "blue" },
      { pattern = "mason", icon = "󱌢", color = "yellow" },
      { pattern = "package", icon = "󰏖", color = "yellow" },
      { pattern = "plugin", icon = "󰜪", color = "cyan" },
      { pattern = "setting", icon = "󰢻", color = "grey" },
      { pattern = "config", icon = "󰢻", color = "grey" },
      { pattern = "help", icon = "󰋗", color = "blue" },
      { pattern = "command", icon = "󰞔", color = "grey" },
      { pattern = "macro", icon = "󰞔", color = "orange" },
      { pattern = "register", icon = "󰌨", color = "purple" },
      { pattern = "spelling", icon = "󰓆", color = "green" },
      { pattern = "color", icon = "󰏘", color = "yellow" },
      { pattern = "theme", icon = "󰏘", color = "yellow" },
      { pattern = "copilot", icon = "󰚩", color = "azure" },
      { pattern = "snacks", icon = "󱥁", color = "yellow" },
      { pattern = "project", icon = "󰉖", color = "blue" },
      { pattern = "colorscheme", icon = "󰏘", color = "purple" },
      { pattern = "dismiss", icon = "󰅖", color = "red" },
      { pattern = "notification", icon = "󰂚", color = "yellow" },
      { pattern = "notify", icon = "󰂚", color = "yellow" },
      { pattern = "info", icon = "󰋽", color = "blue" },
      { pattern = "warning", icon = "󰀪", color = "yellow" },
      { pattern = "error", icon = "󰅚", color = "red" },

      -- ========================================
      -- Oil/File Manager (文件管理器)
      -- ========================================
      { pattern = "browse", icon = "󰆧", color = "cyan" },
      { pattern = "external", icon = "󰎔", color = "orange" },
      { pattern = "hidden", icon = "󰜈", color = "grey" },
      { pattern = "trash", icon = "󰩹", color = "red" },
      { pattern = "refresh", icon = "󰑓", color = "cyan" },
      { pattern = "cwd", icon = "󰉖", color = "blue" },
      { pattern = "parent", icon = "󰁝", color = "cyan" },
      { pattern = "sort", icon = "󰒺", color = "blue" },
      { pattern = "permission", icon = "󰒃", color = "orange" },

      -- ========================================
      -- Built-in Vim Operations (原生操作)
      -- ========================================
      { pattern = "show", icon = "󰈈", color = "yellow" },
      { pattern = "new", icon = "󰎔", color = "green" },
      { pattern = "create", icon = "󰎔", color = "green" },
      { pattern = "print", icon = "󰐪", color = "blue" },
      { pattern = "put", icon = "󰆒", color = "azure" },
      { pattern = "change", icon = "󰶵", color = "orange" },
      { pattern = "substitute", icon = "󰲢", color = "orange" },
      { pattern = "source", icon = "󰅩", color = "blue" },
      { pattern = "suspend", icon = "󰏦", color = "grey" },
      { pattern = "shell", icon = "󰆍", color = "white" },
      { pattern = "mode", icon = "󰆢", color = "purple" },
      { pattern = "char", icon = "󰷂", color = "cyan" },
      { pattern = "line", icon = "󰓢", color = "cyan" },
      { pattern = "word", icon = "󰷂", color = "cyan" },
      { pattern = "paragraph", icon = "󰯼", color = "cyan" },
      { pattern = "indent", icon = "󰌌", color = "green" },
      { pattern = "inner", icon = "󰟵", color = "cyan" },
      { pattern = "around", icon = "󰟶", color = "cyan" },

      -- ========================================
      -- Generic Actions (通用操作)
      -- ========================================
      { pattern = "pick", icon = "󰒆", color = "green" },
      { pattern = "add", icon = "󰐕", color = "green" },
      { pattern = "append", icon = "󰐕", color = "green" },
      { pattern = "watch", icon = "󰔛", color = "yellow" },
      { pattern = "focus", icon = "󰁨", color = "cyan" },
      { pattern = "upgrade", icon = "󰚰", color = "green" },
      { pattern = "update", icon = "󰚰", color = "green" },
      { pattern = "reload", icon = "󰑓", color = "cyan" },
      { pattern = "features", icon = "󰃥", color = "yellow" },
      { pattern = "dependencies", icon = "󱃖", color = "orange" },
      { pattern = "version", icon = "󰦨", color = "blue" },
      { pattern = "homepage", icon = "󰖟", color = "green" },
      { pattern = "repository", icon = "󰳐", color = "purple" },
      { pattern = "document", icon = "󰈙", color = "blue" },
      { pattern = "join", icon = "󰙡", color = "green" },
      { pattern = "operator", icon = "󰘫", color = "blue" },
      { pattern = "enable", icon = "󰔡", color = "green" },
      { pattern = "disable", icon = "󰔢", color = "red" },
      { pattern = "cancel", icon = "󰜺", color = "red" },
      { pattern = "confirm", icon = "󰄬", color = "green" },
      { pattern = "accept", icon = "󰄬", color = "green" },
      { pattern = "reject", icon = "󰜺", color = "red" },
    },
  },

  -- 为主要前缀键添加分组描述
  spec = {
    { "<leader>s", group = "Split/Window", icon = "󰖲" },
    { "<leader>w", group = "Window Jump", icon = "󰁝" },
    { "<leader>t", group = "Tab/Tree", icon = "󰓫" },
    { "<leader>b", group = "Buffer", icon = "󰓩" },
    { "<leader>g", group = "Git", icon = "󰊢" },
    { "<leader>r", group = "Replace/Rename", icon = "󰛔" },
    { "<leader>c", group = "Crates/Code", icon = "󰏖" },
    { "<leader>n", group = "Harpoon", icon = "󱋡" },
    { "<leader>m", group = "Multicursor", icon = "󰇀" },  -- 新增 multicursor 分组
    { "<leader><leader>", group = "Telescope", icon = "󰭎" },
    { "<leader>gp", group = "Git Preview", icon = "󰈈" },
    { "<leader>gt", group = "Git Toggle", icon = "󰔠" },
    { "gp", group = "LSP Preview", icon = "󰈈" },
  },
})
