local status, neogit = pcall(require, "neogit")
if not status then
  vim.notify("没有找到 neogi")
  return
end

neogit.setup({
  graph_style = "unicode",
  process_spinner = true,
})
