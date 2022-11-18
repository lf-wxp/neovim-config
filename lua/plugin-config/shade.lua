local status, shade = pcall(require, "shade")
if not status then
    vim.notify("没有找到 shade")
  return
end

shade.setup({
  overlay_opacity = 50,
  opacity_step = 1,
})
