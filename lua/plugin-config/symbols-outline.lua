
local status, symbols = pcall(require, "symbols-outline")
if not status then
  vim.notify("没有找到 symbols-outline")
  return
end

symbols.setup()
