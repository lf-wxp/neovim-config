local status, dropbar = pcall(require, "dropbar")
if not status then
  vim.notify("dropbar not found")
  return
end

-- Icon definitions (using Nerd Font)
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
  -- Path related icons
  Folder = "󰉋 ",
}

-- Highlight config moved to colorscheme.lua for unified management

-- Dropbar config - Display only
dropbar.setup({
  icons = {
    kinds = {
      symbols = icons,
    },
    ui = {
      bar = {
        separator = " 󰅂 ", -- Separator (using arrow icon)
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
    -- Use safer events, avoid E36 error
    attach_events = { "BufReadPost", "BufWritePost" },
    update_events = {
      buf = { "BufModifiedSet", "FileChangedShellPost", "TextChanged", "TextChangedI" },
      win = { "CursorMoved", "CursorMovedI", "WinResized" },
    },
    hover = false, -- Disable hover interaction
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
      pivots = "", -- Disable quick select
    },
  },
  menu = {
    quick_navigation = false, -- Disable menu navigation
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

-- Note: Highlight config is managed by colorscheme.lua (auto-applied on VimEnter event)

