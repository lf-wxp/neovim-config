local status, indent_blankline = pcall(require, "indent_blankline")
if not status then
    vim.notify("没有找到 indent_blankline")
  return
end

indent_blankline.setup({
  show_current_context = true,
  show_current_context_start = true,
  show_end_of_line = true,
})

vim.opt.list = true
vim.opt.listchars:append("eol:↴")
