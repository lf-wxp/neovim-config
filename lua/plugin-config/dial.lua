-- ╭──────────────────────────────────────────────────────────╮
-- │         dial.nvim - Enhanced Increment/Decrement         │
-- ╰──────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local augend = require("dial.augend")

  require("dial.config").augends:register_group({
    -- Default augends for increment/decrement
    default = {
      -- Numbers
      augend.integer.alias.decimal,     -- decimal integers (0, 1, 2, ...)
      augend.integer.alias.hex,         -- hexadecimal numbers (0x0, 0x1, ...)
      augend.integer.alias.binary,      -- binary numbers (0b0, 0b1, ...)

      -- Dates
      augend.date.alias["%Y/%m/%d"],    -- 2024/01/15
      augend.date.alias["%Y-%m-%d"],    -- 2024-01-15
      augend.date.alias["%m/%d/%Y"],    -- 01/15/2024
      augend.date.alias["%H:%M:%S"],    -- 14:30:00
      augend.date.alias["%H:%M"],       -- 14:30

      -- Constants
      augend.constant.alias.bool,       -- true <-> false
      augend.constant.alias.alpha,      -- a -> b -> c
      augend.constant.alias.Alpha,      -- A -> B -> C

      -- Semantic versioning
      augend.semver.alias.semver,       -- 1.0.0 -> 1.0.1

      -- Custom constants
      augend.constant.new({
        elements = { "and", "or" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "&&", "||" },
        word = false,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "yes", "no" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "on", "off" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "enable", "disable" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "left", "right" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "top", "bottom" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "width", "height" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "horizontal", "vertical" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "asc", "desc" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "get", "post", "put", "delete", "patch" },
        word = true,
        cyclic = true,
      }),
    },
  })
end

return M
