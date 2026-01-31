local status, neogit = pcall(require, "neogit")
if not status then
  vim.notify("没有找到 neogit")
  return
end

neogit.setup({
  graph_style = "unicode",
  process_spinner = true,
})
