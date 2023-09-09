local status, zone = pcall(require, "zone")
if not status then
  vim.notify("没有找到 zone")
  return
end

zone.setup({
  style = "vanish",
  after = 30,   -- Idle timeout
  exclude_filetypes = { "TelescopePrompt", "NvimTree", "neo-tree", "dashboard", "lazy" },
  -- More options to come later

  treadmill = {
    direction = "left",
    headache = true,
    tick_time = 30,     -- Lower, the faster
    -- Opts for Treadmill style
  },
  epilepsy = {
    stage = "aura",     -- "aura" or "ictal"
    tick_time = 100,
  },
  dvd = {
    -- text = {"line1", "line2", "line3", "etc"}
    tick_time = 100,
    -- Opts for Dvd style
  },
})
