-- ╭──────────────────────────────────────────────────────────╮
-- │         dropbar.nvim - Breadcrumb Navigation Config       │
-- ╰──────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local status, dropbar = pcall(require, "dropbar")
  if not status then
    vim.notify("dropbar not found", vim.log.levels.ERROR)
    return
  end

  local icons = {
    File = "󰈙 ",
    Module = "󰏗 ",
    Namespace = "󰌗 ",
    Package = "󰏖 ",
    Class = "󰠱 ",
    Method = "� ",
    Property = "󰜢 ",
    Field = "󰜢 ",
    Constructor = "󰒓 ",
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
    EnumMember = "󰒔 ",
    Struct = "󰙅 ",
    Event = "󰉒 ",
    Operator = "󰆕 ",
    TypeParameter = "󰊄 ",
    Folder = "󰉋 ",
  }

  dropbar.setup({
    icons = {
      kinds = {
        symbols = icons,
      },
      ui = {
        bar = {
          separator = " 󰅂 ",
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
      attach_events = { "BufReadPost", "BufWritePost" },
      update_events = {
        buf = { "BufModifiedSet", "FileChangedShellPost", "TextChanged", "TextChangedI" },
        win = { "CursorMoved", "CursorMovedI", "WinResized" },
      },
      hover = false,
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
        pivots = "",
      },
    },
    menu = {
      quick_navigation = false,
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
end

return M
