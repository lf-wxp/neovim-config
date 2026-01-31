local keys = require("config.keymaps")
local status, toggleterm = pcall(require, "toggleterm")
if not status then
  vim.notify("toggleterm not found")
  return
end

toggleterm.setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.3
    end
  end,
  start_in_insert = true,
  float_opts = {
    border = "solid",
  },
})

local Terminal = require("toggleterm.terminal").Terminal

local ta = Terminal:new({
  direction = "float",
  close_on_exit = true,
})

local tb = Terminal:new({
  direction = "vertical",
  close_on_exit = true,
})

local tc = Terminal:new({
  direction = "horizontal",
  close_on_exit = true,
})


local toggleA = function()
  if ta:is_open() then
    ta:close()
    return
  end
  tb:close()
  tc:close()
  ta:open()
end

local toggleB = function()
  if tb:is_open() then
    tb:close()
    return
  end
  ta:close()
  tc:close()
  tb:open()
end

local toggleC = function()
  if tc:is_open() then
    tc:close()
    return
  end
  ta:close()
  tb:close()
  tc:open()
end

vim.keymap.set({ "n", "t" }, keys.toggleTerm.float, toggleA, { desc = "terminal float" })
vim.keymap.set({ "n", "t" }, keys.toggleTerm.right, toggleB, { desc = "terminal right" })
vim.keymap.set({ "n", "t" }, keys.toggleTerm.bottom, toggleC, { desc = " terminal bottom" })
vim.keymap.set("t", keys.toggleTerm.switch, "<C-\\><C-n>", { desc = "terminal switch" })
