return {
  opts = {
    -- Enable persistent clipboard history
    ring = {
      history_length = 100,
      storage = "shada",
      sync_with_numbered_registers = true,
      cancel_event = "update",
      ignore_registers = { "_", "-", "+", "=" },
    },
    -- Use telescope for telescope integration
    picker = {
      select = {
        action = nil, -- default: put before selection
      },
      telescope = {
        use_default_mappings = true, -- if true, the default mappings of telescope will be used
        mappings = nil,              -- nil to use default telescope mappings, or table of mappings
      },
    },
    -- System clipboard integration
    system_clipboard = {
      sync_with_ring = true,
    },
    -- Highlight after yank
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 200,
    },
    -- Preserve cursor position
    preserve_cursor_position = {
      enabled = true,
    },
    -- Textobj mapping
    textobj = {
      enabled = true,
    },
  },
}
