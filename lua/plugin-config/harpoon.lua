-- ╭──────────────────────────────────────────────────────────────🟢
-- │ harpoon - File Navigation Configuration                    │
-- ╰──────────────────────────────────────────────────────────────🔴

local M = {}

M.setup = function()
  local status, harpoon = pcall(require, "harpoon")
  if not status then
    vim.notify("harpoon not found", vim.log.levels.ERROR)
    return
  end

  harpoon:setup({
    settings = {
      save_on_toggle = true,
      sync_on_ui_close = true,
    },
  })
end

return M
