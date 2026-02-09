-- ╭────────────────────────────────────────────────────────╮
-- │           nvim-autopairs - Auto Pairs Config           │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local autopairs = require("nvim-autopairs")

  autopairs.setup({
    check_ts = true,
    ts_config = {
      lua = { "string" },
      javascript = { "template_string" },
      java = false,
    },
  })

  -- Completion integration: try to integrate with nvim-cmp (if available)
  -- Note: blink.cmp has built-in autopairs support, no extra config needed
  local ok_cmp, cmp = pcall(require, "cmp")
  if ok_cmp then
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
  end
end

return M
