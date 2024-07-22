local keys = require("keybindings");
local status, neoscroll = pcall(require, "neoscroll")
if not status then
  vim.notify("没有找到 neoscroll")
  return
end
neoscroll.setup({
  -- All these keys will be mapped to their corresponding default scrolling animation
  mappings = { '<C-u>', '<C-d>', '<C-b>',
    '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
  hide_cursor = true,          -- Hide cursor while scrolling
  stop_eof = true,             -- Stop at <EOF> when scrolling downwards
  use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
  respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  easing_function = nil,       -- Default easing function
  pre_hook = nil,              -- Function to run before the scrolling animation starts
  post_hook = nil,             -- Function to run after the scrolling animation ends
  performance_mode = false,    -- Disable "Performance Mode" on all buffers.
  easing = "quadratic"
})

local keymap = {
  -- -- Use the "sine" easing function
  -- ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 250; easing = 'sine' }) end;
  -- ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 250; easing = 'sine' }) end;
  -- Use the "circular" easing function
  [keys.neoscroll.scroll_up] = { func = function() neoscroll.ctrl_b({ duration = 250 }) end, desc = "scroll up" },
  [keys.neoscroll.scroll_down] = { func = function() neoscroll.ctrl_f({ duration = 250 }) end, desc = "scroll down"},
}
local modes = { 'n', 'v', 'x' }
for key, val in pairs(keymap) do
  vim.keymap.set(modes, key, val.func, { desc = val.desc })
end
