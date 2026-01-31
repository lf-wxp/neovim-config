local status, marks = pcall(require, "marks")
if not status then
  vim.notify("marks not found")
  return
end

marks.setup({
  -- default_mappings = false,
  builtin_marks = { ".", "<", ">", "^" },
  excluded_filetypes = { "LspsagaHover", "LspsagaCodeAction", "LspsagaHoverDoc" },
})
