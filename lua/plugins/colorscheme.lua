-- ╭──────────────────────────────────────────────────────────╮
-- │                      Colorscheme                          │
-- ╰──────────────────────────────────────────────────────────╯

-- Highlight utility functions
local function get_hl(name)
  return vim.api.nvim_get_hl(0, { name = name })
end

local function set_hl(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

-- Darken a hex color slightly (mix with black by small factor)
local function darken_color(hex, factor)
  if not hex or type(hex) ~= "number" then
    return nil
  end

  -- Extract RGB components (using math operations for Lua 5.1 compatibility)
  local r = math.floor(hex / 65536) % 256
  local g = math.floor(hex / 256) % 256
  local b = hex % 256

  -- Darken by mixing with black
  local dark_r = math.floor(r * (1 - factor))
  local dark_g = math.floor(g * (1 - factor))
  local dark_b = math.floor(b * (1 - factor))

  return dark_r * 65536 + dark_g * 256 + dark_b
end

-- Module highlight configs
local function setup_telescope_highlights()
  local hl_groups = {
    TelescopePreviewNormal = { bg = "#2E323C" },
    TelescopePreviewBorder = { bg = "#2E323C" },
    TelescopeResultsNormal = { bg = "#23272e" },
    TelescopeResultsBorder = { bg = "#23272e" },
  }
  for name, opts in pairs(hl_groups) do
    set_hl(name, opts)
  end
end

local function setup_misc_highlights()
  set_hl("BufferManagerModified", { fg = "#0000af" })

  -- Window separator - transparent (hidden)
  set_hl("WinSeparator", { fg = "NONE", bg = "NONE" })
  set_hl("VertSplit", { fg = "NONE", bg = "NONE" })

  -- Window focus highlights with subtle difference
  -- Active window is slightly darker than inactive window
  local normal_hl = get_hl("Normal")
  local base_bg = normal_hl.bg or "#1a1b26"

  -- Create a slightly darker background for active window (factor 0.03 for very subtle effect)
  local active_bg = darken_color(base_bg, 0.05) or base_bg

  set_hl("ActiveWindow", {
    bg = active_bg,
  })

  set_hl("InactiveWindow", {
    bg = base_bg,
  })

  -- Setup window focus highlights
  setup_window_focus_highlights()
end

-- Highlight the current active window with a different background
function setup_window_focus_highlights()
  local augroup = vim.api.nvim_create_augroup("WindowFocusHighlight", { clear = true })

  -- Current window highlight
  local function highlight_current_window()
    local current_win = vim.api.nvim_get_current_win()

    -- Apply highlights to all windows
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if win == current_win then
        vim.api.nvim_win_set_option(win, "winhighlight", "Normal:ActiveWindow,NormalNC:ActiveWindow")
      else
        vim.api.nvim_win_set_option(win, "winhighlight", "Normal:InactiveWindow,NormalNC:InactiveWindow")
      end
    end
  end

  -- Apply on window enter/leave
  vim.api.nvim_create_autocmd("WinEnter", {
    group = augroup,
    callback = highlight_current_window,
  })

  vim.api.nvim_create_autocmd("WinLeave", {
    group = augroup,
    callback = highlight_current_window,
  })

  -- Apply on VimEnter
  vim.api.nvim_create_autocmd("VimEnter", {
    group = augroup,
    once = true,
    callback = highlight_current_window,
  })
end

local function setup_multicursor_highlights()
  local hl_groups = {
    MultiCursorCursor = { reverse = true },
    MultiCursorVisual = { link = "Visual" },
    MultiCursorSign = { link = "SignColumn" },
    MultiCursorMatchPreview = { link = "Search" },
    MultiCursorDisabledCursor = { reverse = true },
    MultiCursorDisabledVisual = { link = "Visual" },
    MultiCursorDisabledSign = { link = "SignColumn" },
  }
  for name, opts in pairs(hl_groups) do
    set_hl(name, opts)
  end
end

local function setup_symbol_usage_highlights()
  local cursor_bg = get_hl("CursorLine").bg or "#242736"
  local comment_fg = get_hl("Comment").fg or "#565f89"
  local func_fg = get_hl("Function").fg or "#7aa2f7"
  local type_fg = get_hl("Type").fg or "#bb9af7"
  local keyword_fg = get_hl("@keyword").fg or get_hl("Keyword").fg or "#9d7cd8"

  local hl_groups = {
    SymbolUsageRounding = { fg = cursor_bg, italic = true },
    SymbolUsageContent = { bg = cursor_bg, fg = comment_fg, italic = true },
    SymbolUsageRef = { fg = func_fg, bg = cursor_bg, italic = true },
    SymbolUsageDef = { fg = type_fg, bg = cursor_bg, italic = true },
    SymbolUsageImpl = { fg = keyword_fg, bg = cursor_bg, italic = true },
  }
  for name, opts in pairs(hl_groups) do
    set_hl(name, opts)
  end
end

local function setup_dropbar_highlights()
  local normal_hl = get_hl("Normal")
  local bg = normal_hl.bg or "#1a1b26"

  local colors = {
    normal_fg = normal_hl.fg or "#c0caf5",
    normal_bg = bg,
    comment_fg = get_hl("Comment").fg or "#565f89",
    string_fg = get_hl("String").fg or "#9aa5ce",
    func_fg = get_hl("Function").fg or "#7aa2f7",
    type_fg = get_hl("Type").fg or "#bb9af7",
    keyword_fg = get_hl("Keyword").fg or "#9d7cd8",
    constant_fg = get_hl("Constant").fg or "#e0af68",
    special_fg = get_hl("Special").fg or "#7dcfff",
    separator_fg = get_hl("NonText").fg or get_hl("Comment").fg or "#565f89",
  }

  -- Winbar base
  set_hl("WinBar", { fg = colors.normal_fg, bg = colors.normal_bg })
  set_hl("WinBarNC", { fg = colors.comment_fg, bg = colors.normal_bg })
  set_hl("DropBarCurrentContext", { fg = colors.normal_fg, bg = colors.normal_bg, bold = true })
  set_hl("DropBarHover", { fg = colors.func_fg, bg = colors.normal_bg, bold = true })
  set_hl("DropBarIconUISeparator", { fg = colors.separator_fg, bg = colors.normal_bg })
  set_hl("DropBarIconUISeparatorActive", { fg = colors.func_fg, bg = colors.normal_bg })

  -- Path
  set_hl("DropBarIconKindFolder", { fg = colors.keyword_fg, bg = colors.normal_bg })
  set_hl("DropBarIconKindFile", { fg = colors.string_fg, bg = colors.normal_bg })
  set_hl("DropBarKindFolder", { fg = colors.keyword_fg, bg = colors.normal_bg })
  set_hl("DropBarKindFile", { fg = colors.string_fg, bg = colors.normal_bg })

  -- Types
  local type_kinds = { "Class", "Struct", "Interface", "Enum" }
  for _, kind in ipairs(type_kinds) do
    set_hl("DropBarIconKind" .. kind, { fg = colors.type_fg, bg = colors.normal_bg })
    set_hl("DropBarKind" .. kind, { fg = colors.type_fg, bg = colors.normal_bg })
  end
  set_hl("DropBarIconKindEnumMember", { fg = colors.constant_fg, bg = colors.normal_bg })
  set_hl("DropBarKindEnumMember", { fg = colors.constant_fg, bg = colors.normal_bg })

  -- Functions/Methods
  local func_kinds = { "Function", "Method", "Constructor" }
  for _, kind in ipairs(func_kinds) do
    set_hl("DropBarIconKind" .. kind, { fg = colors.func_fg, bg = colors.normal_bg })
    set_hl("DropBarKind" .. kind, { fg = colors.func_fg, bg = colors.normal_bg })
  end

  -- Variables
  local var_kinds = { "Variable", "Field", "Property" }
  for _, kind in ipairs(var_kinds) do
    set_hl("DropBarIconKind" .. kind, { fg = colors.normal_fg, bg = colors.normal_bg })
    set_hl("DropBarKind" .. kind, { fg = colors.normal_fg, bg = colors.normal_bg })
  end

  -- Constants
  set_hl("DropBarIconKindConstant", { fg = colors.constant_fg, bg = colors.normal_bg })
  set_hl("DropBarIconKindString", { fg = colors.string_fg, bg = colors.normal_bg })
  set_hl("DropBarIconKindNumber", { fg = colors.constant_fg, bg = colors.normal_bg })
  set_hl("DropBarIconKindBoolean", { fg = colors.constant_fg, bg = colors.normal_bg })
  set_hl("DropBarKindConstant", { fg = colors.constant_fg, bg = colors.normal_bg })
  set_hl("DropBarKindString", { fg = colors.string_fg, bg = colors.normal_bg })
  set_hl("DropBarKindNumber", { fg = colors.constant_fg, bg = colors.normal_bg })
  set_hl("DropBarKindBoolean", { fg = colors.constant_fg, bg = colors.normal_bg })

  -- Others
  local keyword_kinds = { "Module", "Namespace", "Package", "Key" }
  for _, kind in ipairs(keyword_kinds) do
    set_hl("DropBarIconKind" .. kind, { fg = colors.keyword_fg, bg = colors.normal_bg })
    set_hl("DropBarKind" .. kind, { fg = colors.keyword_fg, bg = colors.normal_bg })
  end

  local special_kinds = { "Event", "Operator" }
  for _, kind in ipairs(special_kinds) do
    set_hl("DropBarIconKind" .. kind, { fg = colors.special_fg, bg = colors.normal_bg })
    set_hl("DropBarKind" .. kind, { fg = colors.special_fg, bg = colors.normal_bg })
  end

  local type_misc_kinds = { "Array", "Object", "TypeParameter" }
  for _, kind in ipairs(type_misc_kinds) do
    set_hl("DropBarIconKind" .. kind, { fg = colors.type_fg, bg = colors.normal_bg })
    set_hl("DropBarKind" .. kind, { fg = colors.type_fg, bg = colors.normal_bg })
  end

  set_hl("DropBarIconKindNull", { fg = colors.comment_fg, bg = colors.normal_bg })
  set_hl("DropBarKindNull", { fg = colors.comment_fg, bg = colors.normal_bg })
end

-- Apply all highlights
local function setup_all_highlights()
  setup_telescope_highlights()
  setup_misc_highlights()
  setup_multicursor_highlights()
  setup_symbol_usage_highlights()
  setup_dropbar_highlights()
end

-- Reapply highlights on colorscheme change
local augroup = vim.api.nvim_create_augroup("ColorSchemeHighlights", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.defer_fn(setup_all_highlights, 10)
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup,
  callback = function()
    vim.defer_fn(setup_all_highlights, 100)
  end,
})

-- ╭──────────────────────────────────────────────────────────╮
-- │                      Plugin Config                        │
-- ╰──────────────────────────────────────────────────────────╯

return {
  -- Primary colorscheme
  {
    "glepnir/zephyr-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("zephyr")
      setup_all_highlights()
    end,
  },

  -- Alternative colorschemes
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
}
