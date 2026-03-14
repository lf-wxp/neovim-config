-- ╭────────────────────────────────────────────────────────╮
-- │                  LSP UI Config                         │
-- │                                                        │
-- │ Purpose: Configure LSP diagnostic display style        │
-- │ Features:                                              │
-- │   1. Virtual text for inline diagnostic messages       │
-- │   2. Diagnostic severity signs with Nerd Font icons    │
-- │   3. Floating window style for diagnostic details      │
-- │   4. Severity-based sorting for prioritized display    │
-- ╰────────────────────────────────────────────────────────╯

vim.diagnostic.config({
  -- Show diagnostic messages as virtual text at end of line
  virtual_text = {
    spacing = 4, -- Spaces before virtual text
    prefix = "●", -- Symbol before diagnostic message
  },
  -- Diagnostic signs in the sign column
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  -- Defer updates until leaving insert mode (avoid flicker while typing)
  update_in_insert = false,
  -- Underline diagnostic ranges
  underline = true,
  -- Show most severe diagnostics first
  severity_sort = true,
  -- Floating window appearance for diagnostic details
  -- Note: border inherits from vim.o.winborder (set in options.lua)
  float = {
    source = true, -- Always show which LSP server produced the diagnostic
    style = "minimal",
    header = "",
  },
})
