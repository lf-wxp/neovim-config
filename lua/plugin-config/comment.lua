-- ╭──────────────────────────────────────────────────────────╮
-- │         Comment.nvim - Smart Commenting                  │
-- ╰──────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  require("Comment").setup({
    -- Add space after comment string
    padding = true,
    -- Whether cursor should stay at the same position
    sticky = true,
    -- Lines to be ignored while comment/uncomment
    ignore = nil,
    -- LHS of toggle mappings in NORMAL mode
    toggler = {
      ---Line-comment toggle keymap
      line = "gcc",
      ---Block-comment toggle keymap
      block = "gbc",
    },
    -- LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      ---Line-comment keymap
      line = "gc",
      ---Block-comment keymap
      block = "gb",
    },
    -- LHS of extra mappings
    extra = {
      ---Add comment on the line below
      below = "gco",
      ---Add comment on the line above
      above = "gcO",
      ---Add comment at the end of line
      eol = "gcA",
    },
    -- Enable keybindings
    mappings = {
      ---Operator-pending mapping: `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = true,
      ---Extra mapping: `gco`, `gcO`, `gcA`
      extra = true,
    },
    -- Function to call before (un)comment
    pre_hook = nil,
    -- Function to call after (un)comment
    post_hook = nil,
  })
end

return M
