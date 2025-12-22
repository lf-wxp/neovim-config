local keys = require("keybindings");
local status, cinnamon = pcall(require, "cinnamon")
if not status then
  vim.notify("没有找到 cinnamon")
  return
end
cinnamon.setup({
  keymaps = {
    basic = true,
    extra = true,
  },
})

local keymap = {
  [keys.neoscroll.scroll_up] = { func = function() cinnamon.scroll("<C-U>zz") end, desc = "scroll up" },
  [keys.neoscroll.scroll_down] = { func = function() cinnamon.scroll("<C-D>zz") end, desc = "scroll down" },
}
local modes = { 'n', 'v', 'x' }
for key, val in pairs(keymap) do
  vim.keymap.set(modes, key, val.func, { desc = val.desc })
end
