-- ╭────────────────────────────────────────────────────────╮
-- │                  LSP UI Config                         │
-- │                                                        │
-- │ Purpose: Configure LSP diagnostic display              │
-- │ Features:                                              │
-- │   1. Virtual text for diagnostic messages              │
-- │   2. Set diagnostic signs and icons                    │
-- │   3. Configure diagnostic floating window style        │
-- ╰────────────────────────────────────────────────────────╯

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  -- Update hints after leaving insert mode to avoid performance issues
  update_in_insert = false,
  underline = true,
  show_header = false,
  severity_sort = true,
  float = {
    source = "always",
    border = "none",
    style = "minimal",
    header = "",
    -- prefix = " ",
    -- max_width = 100,
    -- width = 60,
    -- height = 20,
  },
})
