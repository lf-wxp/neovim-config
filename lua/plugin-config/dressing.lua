local status, dressing = pcall(require, "dressing")
if not status then
  vim.notify("没有找到 dressing")
  return
end

dressing.setup()
