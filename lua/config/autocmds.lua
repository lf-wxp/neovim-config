-- ╭──────────────────────────────────────────────────────────╮
-- │                      Auto Commands                        │
-- ╰──────────────────────────────────────────────────────────╯

local augroup = vim.api.nvim_create_augroup("UserAutoCommands", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Auto close nvim-tree: quit when only nvim-tree window remains
autocmd("BufEnter", {
  nested = true,
  group = augroup,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd("quit")
    end
  end,
})

-- Enter insert mode when opening terminal
autocmd("TermOpen", {
  group = augroup,
  command = "startinsert",
})

-- Format on save
autocmd("BufWritePre", {
  group = augroup,
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Don't continue comments on new line with o
autocmd("BufEnter", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions
      - "o" -- O and o don't continue comments
      + "r" -- But Enter will continue
  end,
})

-- Detect stdin (for auto-session)
autocmd("StdinReadPre", {
  group = augroup,
  callback = function()
    vim.g.using_stdin = true
  end,
})
