local status, preview = pcall(require, "fold-preview")

local map = preview.mapping
local keymap = vim.keymap
keymap.amend = require('keymap-amend')
if not status then
  vim.notify("没有找到 fold-preview")
  return
end

preview.setup({
  border = "solid",
  default_keybindings = false
})

keymap.amend('n', 'K', function(original)
  -- if not preview.show_preview() then original() end
  -- or
  if not preview.toggle_preview() then original() end
  -- to close preview on second press on K.
end)

keymap.amend('n', 'zo', map.close_preview)
keymap.amend('n', 'zO', map.close_preview)
keymap.amend('n', 'zc', map.close_preview_without_defer)
keymap.amend('n', 'zR', map.close_preview)
keymap.amend('n', 'zM', map.close_preview_without_defer)
