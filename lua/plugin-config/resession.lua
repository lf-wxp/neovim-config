local status, resession = pcall(require, "resession")
if not status then
  vim.notify("没有找到 resession")
  return
end


resession.setup(
  {
    autosave = {
      enabled = true,
      -- How often to save (in seconds)
      interval = 600,
      -- Notify when autosaved
      notify = true,
    },
  }
)
