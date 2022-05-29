local status, which_key = pcall(require, "which-key")
if not status then
  vim.notify("没有找到 which-key")
  return
end

which_key.setup()
