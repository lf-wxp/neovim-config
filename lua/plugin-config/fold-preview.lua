local status, preview = pcall(require, "fold-preview")
if not status then
  vim.notify("没有找到 fold-preview")
  return
end

preview.setup({
  border = "solid",
})
