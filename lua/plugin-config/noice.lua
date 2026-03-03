-- ╭────────────────────────────────────────────────────────╮
-- │    noice.nvim - Cmdline/Notify/Search UI Configuration │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  require("noice").setup({
    -- Command line UI
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
      opts = {
        win_options = { winblend = 20 },
        border = { style = { " ", " ", " ", " ", " ", " ", " ", " " }, padding = { 0, 0 } },
        -- border = { style = "none", padding = { 1, 2 } },
      },
      format = {
        cmdline = { pattern = "^:", icon = "󰘳 ", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        filter = { pattern = "^:%s*!", icon = " ", lang = "bash" },
        lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "󰢱 ", lang = "lua" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = "󰘥 " },
        input = { view = "cmdline_input", icon = "󰥻 " },
      },
    },

    -- Messages configuration
    messages = {
      enabled = true,
      view = "notify",
      view_error = "notify",
      view_warn = "notify",
      view_history = "messages",
      view_search = "virtualtext",
    },

    -- Popup menu configuration
    popupmenu = {
      enabled = true,
      ---@type 'nui'|'cmp'
      backend = "nui",
      kind_icons = {
        File = "󰈙 ",
        Module = "󰏗 ",
        Namespace = "󰌗 ",
        Package = "󰏖 ",
        Class = "󰠱 ",
        Method = "󰆧 ",
        Property = "󰜢 ",
        Field = "󰜢 ",
        Constructor = "󰒓 ",
        Enum = "󰕘 ",
        Interface = "󰕘 ",
        Function = "󰊕 ",
        Variable = "󰀫 ",
        Constant = "󰏿 ",
        String = "󰀬 ",
        Number = "󰎠 ",
        Boolean = "󰨙 ",
        Array = "󰅪 ",
        Object = "󰅩 ",
        Key = "󰌋 ",
        Null = "󰟢 ",
        EnumMember = "󰕘 ",
        Struct = "󰙅 ",
        Event = "󰉒 ",
        Operator = "󰆕 ",
        TypeParameter = "󰊄 ",
        Folder = "󰉋 ",
        Unit = "󰑭 ",
        Value = "󰎠 ",
        Text = "󰉿 ",
        Reference = "󰈇 ",
        Keyword = "󰌋 ",
        Snippet = "󰒕 ",
        Color = "󰏘 ",
        Calendar = "󰃭 ",
        Watch = "󰥔 ",
        Copilot = "󰚩 ",
        Codeium = "󰘦 ",
        TabNine = "󰚩 ",
      },
    },

    -- LSP integration
    lsp = {
      progress = {
        enabled = false,
        format = "lsp_progress",
        format_done = "lsp_progress_done",
        throttle = 1000 / 30,
        view = "mini",
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        -- blink.cmp does not need this override
        -- ["cmp.entry.get_documentation"] = true,
      },
      hover = { enabled = true, silent = true, view = "hover" },
      signature = { enabled = false },
      message = { enabled = true, view = "notify" },
    },

    -- Presets
    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },

    -- Message routing rules
    routes = {
      -- Hide written messages
      { filter = { event = "msg_show", kind = "", find = "written" }, opts = { skip = true } },
      -- Hide undo/redo messages
      { filter = { event = "msg_show", find = "^%d+ fewer lines" }, opts = { skip = true } },
      { filter = { event = "msg_show", find = "^%d+ more lines" }, opts = { skip = true } },
      { filter = { event = "msg_show", find = "^%d+ lines " }, opts = { skip = true } },
      -- Hide yank/paste messages
      { filter = { event = "msg_show", find = "^%d+ line[s]? yanked" }, opts = { skip = true } },
      { filter = { event = "msg_show", find = "^%d+ line[s]? >ed" }, opts = { skip = true } },
      -- Hide search wrap messages
      { filter = { event = "msg_show", find = "search hit %a* continuing at %a*" }, opts = { skip = true } },
      -- Hide change replace messages
      { filter = { event = "msg_show", find = "%d+ change[s]?;" }, opts = { skip = true } },
      -- Hide "Already at newest/oldest change" messages
      { filter = { event = "msg_show", find = "Already at %a+ change" }, opts = { skip = true } },
      -- Hide "No lines in buffer" message
      { filter = { event = "msg_show", find = "No lines in buffer" }, opts = { skip = true } },
      -- Hide macro recording messages
      { filter = { event = "msg_show", kind = "echomsg", find = "recording @%a" }, view = "mini" },
      { filter = { event = "msg_show", kind = "echomsg", find = "recording complete" }, view = "mini" },
      -- Show search count in mini view
      { view = "mini", filter = { event = "msg_show", kind = "search_count" } },
    },

    -- Views configuration
    views = {
      confirm = {
        win_options = { winblend = 15 },
        border = { style = { " ", " ", " ", " ", " ", " ", " ", " " }, padding = { 0, 0 }, text = {} },
        -- border = { style = "none", padding = { 1, 2 }, text = {} },
      },
      cmdline_popup = {
        filter_options = {},
        win_options = { winblend = 15 },
        position = { row = "40%", col = "50%" },
        size = { min_width = 60, width = "auto", height = "auto" },
      },
      cmdline_popupmenu = {
        relative = "editor",
        position = { row = "40%", col = "50%" },
        size = { width = 60, height = 10 },
        win_options = { winblend = 15, cursorline = true, cursorlineopt = "both" },
      },
      hover = {
        win_options = { winblend = 10 },
        size = { max_width = 80, max_height = 20 },
      },
      notify = {
        replace = true,
        merge = false,
      },
      mini = {
        win_options = { winblend = 0 },
        timeout = 5000,
      },
    },
  })
end

return M
