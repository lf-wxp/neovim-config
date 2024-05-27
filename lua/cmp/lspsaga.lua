local status, lspsaga = pcall(require, "lspsaga")
if not status then
  vim.notify("没有找到 lspsaga")
  return
end

lspsaga.setup({
  scroll_preview = {
    scroll_down = 'sd',
    scroll_up = 'su',
  }
})
