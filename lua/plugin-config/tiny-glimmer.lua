local status, tiny_glimmer = pcall(require, "tiny-glimmer")
if not status then
  vim.notify("没有找到 tiny-glimmer")
  return
end

tiny_glimmer.setup({
  overwrite = {
    search = {
      enabled = true,
      default_animation = "pulse",
    },
    undo = {
      enabled = true,
    },
    redo = {
      enabled = true,
    }
  }
})
