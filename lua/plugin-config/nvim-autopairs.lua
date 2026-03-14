-- ╭────────────────────────────────────────────────────────╮
-- │           nvim-autopairs - Auto Pairs Config           │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local autopairs = require("nvim-autopairs")

  autopairs.setup({
    check_ts = true,
    map_bs = false,
    ts_config = {
      lua = { "string" },
      javascript = { "template_string" },
      java = false,
    },
  })
end

return M
