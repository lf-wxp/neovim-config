local status, vgit = pcall(require, "vgit")
if not status then
    vim.notify("没有找到 vgit")
  return
end

vgit.setup({})
