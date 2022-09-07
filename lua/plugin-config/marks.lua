local status, marks = pcall(require, "marks")
if not status then
    vim.notify("没有找到 marks")
  return
end

marks.setup({
  -- default_mappings = false,
  builtin_marks = { ".", "<", ">", "^" },
  excluded_filetypes = {'LspsagaHover', 'LspsagaCodeAction', 'LspsagaHoverDoc'}
})
