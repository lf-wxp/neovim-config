-- ╭────────────────────────────────────────────────────────╮
-- │         Shared Icon Definitions                        │
-- │ Single source of truth for kind_icons used by          │
-- │ blink.cmp, noice.nvim, and other plugins               │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

-- stylua: ignore start
M.kind_icons = {
  Text          = "󰉿",
  Method        = "󰆧",
  Function      = "󰆧",
  Constructor   = "󰒓",
  Field         = "󰜢",
  Variable      = "󰀫",
  Class         = "󰠱",
  Interface     = "󰕘",
  Module        = "󰏓",
  Property      = "󰜢",
  Unit          = "󰑭",
  Value         = "󰎠",
  Enum          = "󰕘",
  Keyword       = "󰌋",
  Snippet       = "󰒕",
  Color         = "󰏘",
  File          = "󰈚",
  Reference     = "󰈇",
  Folder        = "󰉋",
  EnumMember    = "󰕘",
  Constant      = "󰏿",
  Struct        = "󰙅",
  Event         = "󰉒",
  Operator      = "󰆕",
  TypeParameter = "󰊄",
  Namespace     = "󰌗",
  Table         = "󰓫",
  Object        = "󰕰",
  Tag           = "󰓹",
  Array         = "󰅪",
  Boolean       = "󰨈",
  Number        = "󰎠",
  Null          = "󰟢",
  String        = "󰉿",
  Calendar      = "󰃭",
  Watch         = "󰥔",
  Package       = "󰆦",
  Copilot       = "󰚩",
  Codeium       = "󰘦",
  TabNine       = "󰚩",
}
-- stylua: ignore end

--- Get kind_icons with trailing space (for noice popupmenu format)
--- @return table<string, string>
M.kind_icons_spaced = function()
  local spaced = {}
  for k, v in pairs(M.kind_icons) do
    spaced[k] = v .. " "
  end
  return spaced
end

return M
