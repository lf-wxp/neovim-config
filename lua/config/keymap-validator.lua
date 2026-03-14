-- ╭────────────────────────────────────────────────────────╮
-- │              Keymap Conflict Validator                 │
-- │                                                        │
-- │ Purpose: Detect and report keymap conflicts            │
-- │ Usage: Called during startup or manually               │
-- ╰────────────────────────────────────────────────────────╯

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

--- Check for prefix-shadowing conflicts in keymaps
--- nvim_get_keymap returns only the final mapping per key, so duplicate detection
--- is impossible. Instead, we detect prefix-shadowing: when key A is a strict
--- prefix of key B, pressing A will fire immediately and B becomes unreachable.
---@param mode string Vim mode to check
---@param report boolean Whether to notify conflicts
---@return table conflicts found
function M.check_conflicts(mode, report)
  local keymaps = collect_keymaps(mode)
  local conflicts = {}

  -- Collect all lhs keys and sort by length (shortest first)
  local keys = {}
  for lhs, _ in pairs(keymaps) do
    table.insert(keys, lhs)
  end
  table.sort(keys, function(a, b) return #a < #b end)

  -- Check if any shorter key is a strict prefix of a longer key
  for i = 1, #keys do
    for j = i + 1, #keys do
      local short_key = keys[i]
      local long_key = keys[j]
      -- Only flag when the short key has a non-nil rhs/callback (i.e. it fires an action)
      -- Skip if the short key is a which-key group (desc contains "group" pattern or rhs is empty)
      local short_map = keymaps[short_key]
      local has_action = short_map.callback ~= nil or (short_map.rhs and short_map.rhs ~= "")

      if has_action and long_key:sub(1, #short_key) == short_key then
        table.insert(conflicts, {
          short_key = short_key,
          long_key = long_key,
          mode = mode,
          short_desc = short_map.desc,
          long_desc = keymaps[long_key].desc,
        })
      end
    end
  end

  if report and #conflicts > 0 then
    for _, conflict in ipairs(conflicts) do
      vim.notify(
        string.format(
          "[Keymap Prefix Shadowing] %s mode: '%s' (%s) shadows '%s' (%s)",
          mode:upper(),
          conflict.short_key,
          conflict.short_desc,
          conflict.long_key,
          conflict.long_desc
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

--- Run validation or show statistics
---@param show_stats boolean Whether to show statistics instead of conflict check
function M.run(show_stats)
  if show_stats then
    M.show_statistics()
  else
    local conflicts = M.check_all_modes(true)
    if not next(conflicts) then
      vim.notify("No keymap conflicts found!", vim.log.levels.INFO)
    end
  end
end

return M
