local keys = require("keybindings")
local status, comment = pcall(require, "Comment")
if not status then
  vim.notify("没有找到 Comment")
  return
end

local opts = {
  mappings = {
    -- 关闭了extra快捷键
    extra = false,
  },

  -- Normal 模式快捷键
  toggler = {
    line = keys.comment.toggler.line, -- 行注释
    block = keys.comment.toggler.block, -- 块注释
  },
  -- Visual 模式
  opleader = {
    line = keys.comment.opleader.line,
    bock = keys.comment.opleader.block,
  },

  -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
comment.setup(opts)
