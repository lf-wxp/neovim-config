-- ╭──────────────────────────────────────────────────────────╮
-- │                 Keymap Conflict Validator                │
-- │                                                             │
-- │ Purpose: Detect and report keymap conflicts             │
-- │ Usage: Called during startup or manually                │
-- ╰──────────────────────────────────────────────────────────╯

local M = {}

--- Collect all keymaps for a given mode
---@param mode string Vim mode (n, v, i, etc.)
---@return table Map of key to rhs
local function collect_keymaps(mode)
  local keymaps = vim.api.nvim_get_keymap(mode)
  local result = {}

  for _, map in ipairs(keymaps) do
    -- Skip special keys and builtins
    if map.lhs and map.rhs and not map.lhs:match("^<Plug>") then
      result[map.lhs] = {
        rhs = map.rhs,
        callback = map.callback,
        desc = map.desc or "No description",
        script_id = map.script_id,
      }
    end
  end

  return result
end

--- Check for conflicts in keymaps
---@param mode string Vim mode to check
---@param report boolean Whether to notify conflicts
---@return table conflicts found
function M.check_conflicts(mode, report)
  local keymaps = collect_keymaps(mode)
  local conflicts = {}
  local checked = {}

  for lhs, map in pairs(keymaps) do
    if checked[lhs] then
      table.insert(conflicts, {
        key = lhs,
        mode = mode,
        mapping1 = checked[lhs].desc,
        mapping2 = map.desc,
        rhs1 = checked[lhs].rhs,
        rhs2 = map.rhs,
      })
    else
      checked[lhs] = map
    end
  end

  if report and #conflicts > 0 then
    for _, conflict in ipairs(conflicts) do
      vim.notify(
        string.format(
          "[Keymap Conflict] %s mode: '%s' conflicts:\n  1. %s (%s)\n  2. %s (%s)",
          mode:upper(),
          conflict.key,
          conflict.mapping1,
          conflict.rhs1,
          conflict.mapping2,
          conflict.rhs2
        ),
        vim.log.levels.WARN
      )
    end
  end

  return conflicts
end

--- Check all modes for conflicts
---@param report boolean Whether to notify conflicts
---@return table all conflicts
function M.check_all_modes(report)
  local modes = { "n", "v", "i", "c", "t", "o" }
  local all_conflicts = {}

  for _, mode in ipairs(modes) do
    local conflicts = M.check_conflicts(mode, report)
    if #conflicts > 0 then
      all_conflicts[mode] = conflicts
    end
  end

  return all_conflicts
end

--- Show keymap statistics
function M.show_statistics()
  local modes = { "n", "v", "i", "c", "t", "o" }
  local stats = {}

  for _, mode in ipairs(modes) do
    local keymaps = collect_keymaps(mode)
    stats[mode] = {
      count = 0,
      has_desc = 0,
      no_desc = 0,
    }

    for _, map in pairs(keymaps) do
      stats[mode].count = stats[mode].count + 1
      if map.desc and map.desc ~= "No description" then
        stats[mode].has_desc = stats[mode].has_desc + 1
      else
        stats[mode].no_desc = stats[mode].no_desc + 1
      end
    end
  end

  -- Print statistics
  local lines = { "═══════════════════════════════════════", "  Keymap Statistics", "═══════════════════════════════════════" }

  for _, mode in ipairs(modes) do
    local mode_name = mode:upper()
    local mode_stats = stats[mode]
    if mode_stats.count > 0 then
      table.insert(lines, string.format(
        "  %s Mode: %d mappings (described: %d, undescribed: %d)",
        mode_name,
        mode_stats.count,
        mode_stats.has_desc,
        mode_stats.no_desc
      ))
    end
  end

  table.insert(lines, "═══════════════════════════════════════")

  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end

--- Create user command for validation
M.setup = function()
  vim.api.nvim_create_user_command("KeymapValidate", function(opts)
    if opts.bang then
      -- Show statistics
      M.show_statistics()
    else
      -- Check conflicts
      local conflicts = M.check_all_modes(true)
      if not next(conflicts) then
        vim.notify("No keymap conflicts found!", vim.log.levels.INFO)
      end
    end
  end, {
    bang = true,
    desc = "Validate keymap conflicts and show statistics",
  })
end

return M
