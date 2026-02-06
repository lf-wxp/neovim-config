-- ╭──────────────────────────────────────────────────────────╮
-- │                    LSP UI Config                          │
-- │                                                             │
-- │ 用途: 配置 LSP 诊断信息的显示方式                          │
-- │ 功能:                                                       │
-- │   1. 虚拟文本显示诊断信息                                  │
-- │   2. 设置诊断符号和图标                                    │
-- │   3. 配置诊断浮动窗口样式                                   │
-- ╰──────────────────────────────────────────────────────────╯

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  -- Update hints in insert mode, setting to true may affect performance
  update_in_insert = true,
  underline = true,
  show_header = false,
  severity_sort = true,
  float = {
    source = "always",
    border = "rounded",
    style = "minimal",
    header = "",
    -- prefix = " ",
    -- max_width = 100,
    -- width = 60,
    -- height = 20,
  },
})
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
