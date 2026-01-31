local status, dropbar = pcall(require, "dropbar")
if not status then
  vim.notify("没有找到 dropbar")
  return
end

-- 美观的图标定义 (使用 Nerd Font)
local icons = {
  File = "󰈙 ",
  Module = "󰏗 ",
  Namespace = "󰌗 ",
  Package = "󰏖 ",
  Class = "󰌗 ",
  Method = "󰊕 ",
  Property = "󰆧 ",
  Field = "󰜢 ",
  Constructor = " ",
  Enum = "󰕘 ",
  Interface = "󰕘 ",
  Function = "󰊕 ",
  Variable = "󰀫 ",
  Constant = "󰏿 ",
  String = "󰀬 ",
  Number = "󰎠 ",
  Boolean = "󰨙 ",
  Array = "󰅪 ",
  Object = "󰅩 ",
  Key = "󰌋 ",
  Null = "󰟢 ",
  EnumMember = " ",
  Struct = "󰌗 ",
  Event = " ",
  Operator = "󰆕 ",
  TypeParameter = "󰊄 ",
  -- 路径相关图标
  Folder = "󰉋 ",
}

-- 高亮配置已移至 colorscheme.lua 统一管理

-- Dropbar 配置 - 仅展示功能
dropbar.setup({
  icons = {
    kinds = {
      symbols = icons,
    },
    ui = {
      bar = {
        separator = " 󰅂 ", -- 分隔符（使用明显的箭头图标）
        extends = "…",
      },
      menu = {
        separator = " ",
        indicator = " ",
      },
    },
  },
  bar = {
    enable = true,
    -- 使用更安全的事件，避免 E36 错误
    attach_events = { "BufReadPost", "BufWritePost" },
    update_events = {
      buf = { "BufModifiedSet", "FileChangedShellPost", "TextChanged", "TextChangedI" },
      win = { "CursorMoved", "CursorMovedI", "WinResized" },
    },
    hover = false, -- 禁用悬停交互
    sources = function(buf, _)
      local sources = require("dropbar.sources")
      local utils = require("dropbar.utils")
      if vim.bo[buf].ft == "markdown" then
        return {
          sources.path,
          sources.markdown,
        }
      end
      if vim.bo[buf].buftype == "terminal" then
        return {
          sources.terminal,
        }
      end
      return {
        sources.path,
        utils.source.fallback({
          sources.lsp,
          sources.treesitter,
        }),
      }
    end,
    padding = {
      left = 1,
      right = 1,
    },
    pick = {
      pivots = "", -- 禁用快速选择
    },
  },
  menu = {
    quick_navigation = false, -- 禁用菜单导航
    entry = {
      padding = {
        left = 1,
        right = 1,
      },
    },
  },
  sources = {
    path = {
      relative_to = function()
        return vim.fn.getcwd()
      end,
    },
  },
})

-- 注：高亮配置已由 colorscheme.lua 统一管理（VimEnter 事件自动应用）

