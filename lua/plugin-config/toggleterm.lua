local keys = require("keybindings")
local status, toggleterm = pcall(require, "toggleterm")
if not status then
  vim.notify("没有找到 toggleterm")
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

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "solid",
  },
  on_open = function(term)
    vim.cmd("startinsert!")
    -- q / <leader>tg 关闭 terminal
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<cr>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<leader>tg", "<cmd>close<cr>", { noremap = true, silent = true })
    -- ESC 键取消，留给lazygit
    if vim.fn.mapcheck("<Esc>", "t") ~= "" then
      vim.api.nvim_del_keymap("t", "<Esc>")
    end
  end,
  on_close = function(_)
    -- 添加回来
    vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {
      noremap = true,
      silent = true,
    })
  end,
})

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

local toggleG = function()
  lazygit:toggle()
end

vim.keymap.set({ "n", "t" }, keys.toggleTerm.float, toggleA, { desc = "terminal float" })
vim.keymap.set({ "n", "t" }, keys.toggleTerm.right, toggleB, { desc = "terminal right" })
vim.keymap.set({ "n", "t" }, keys.toggleTerm.bottom, toggleC, { desc = " terminal bottom" })
vim.keymap.set({ "n", "t" }, keys.toggleTerm.lazygit, toggleG, { desc = " terminal lazygit" })
vim.keymap.set("t", keys.toggleTerm.switch, "<C-\\><C-n>", { desc = "terminal switch" })
