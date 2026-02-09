-- ╭────────────────────────────────────────────────────────╮
-- │                    Colorscheme                         │
-- ╰────────────────────────────────────────────────────────╯

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

-- Highlight the current active window with a different background
local function setup_window_focus_highlights()
  local augroup = vim.api.nvim_create_augroup("WindowFocusHighlight", { clear = true })

  -- Current window highlight
  local function highlight_current_window()
    local current_win = vim.api.nvim_get_current_win()

    -- Apply highlights to all windows (skip floating windows to preserve their own winhighlight)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local win_config = vim.api.nvim_win_get_config(win)
      if win_config.relative == "" then
        -- Only apply to normal (non-floating) windows
        if win == current_win then
          vim.wo[win].winhighlight = "Normal:ActiveWindow,NormalNC:ActiveWindow"
        else
          vim.wo[win].winhighlight = "Normal:InactiveWindow,NormalNC:InactiveWindow"
        end
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

local function setup_misc_highlights()
  set_hl("BufferManagerModified", { fg = "#0000af" })

  -- Window separator - transparent (hidden)
  set_hl("WinSeparator", { fg = "NONE", bg = "NONE" })
  set_hl("VertSplit", { fg = "NONE", bg = "NONE" })

  -- Window focus highlights with subtle difference
  -- Active window is slightly darker than inactive window
  local normal_hl = get_hl("Normal")
  local base_bg = normal_hl.bg or "#1a1b26"

  -- Floating window background consistent with editor (remove bright NormalFloat from zephyr theme)
  set_hl("NormalFloat", { fg = normal_hl.fg, bg = base_bg })
  set_hl("FloatBorder", { fg = base_bg, bg = base_bg })

  -- Create a slightly darker background for active window (factor 0.05 for very subtle effect)
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

local function setup_blink_highlights()
  local normal_hl = get_hl("Normal")
  local base_bg = normal_hl.bg or 0x1a1b26
  local sel_bg = darken_color(base_bg, -0.1) or 0x2a2e3a

  -- Derive colors from current colorscheme
  local colors = {
    func     = get_hl("Function").fg or 0x7aa2f7,  -- blue
    type     = get_hl("Type").fg or 0xbb9af7,       -- purple
    keyword  = get_hl("Keyword").fg or 0x9d7cd8,    -- violet
    string   = get_hl("String").fg or 0x9ece6a,     -- green
    constant = get_hl("Constant").fg or 0xe0af68,   -- orange/yellow
    special  = get_hl("Special").fg or 0x7dcfff,    -- cyan
    comment  = get_hl("Comment").fg or 0x565f89,    -- dim
    error    = get_hl("DiagnosticError").fg or 0xf7768e, -- red
    normal   = normal_hl.fg or 0xc0caf5,            -- default fg
    info     = get_hl("DiagnosticInfo").fg or 0x7dcfff, -- info blue
  }

  -- ── Menu chrome (background consistent with editor) ──
  set_hl("BlinkCmpMenu",          { bg = base_bg })
  set_hl("BlinkCmpMenuBorder",    { fg = base_bg, bg = base_bg })
  set_hl("BlinkCmpMenuSelection", { bg = sel_bg, bold = true })
  set_hl("BlinkCmpScrollBarThumb", { bg = colors.comment })
  set_hl("BlinkCmpScrollBarGutter", { bg = base_bg })

  -- ── Label ──
  set_hl("BlinkCmpLabel",            { fg = colors.normal, bg = "NONE" })
  set_hl("BlinkCmpLabelMatch",       { fg = colors.func, bold = true })
  set_hl("BlinkCmpLabelDescription", { fg = colors.comment, italic = true })
  set_hl("BlinkCmpLabelDeprecated",  { fg = colors.comment, strikethrough = true })
  set_hl("BlinkCmpLabelDetail",      { fg = colors.comment })

  -- ── Source tag ──
  set_hl("BlinkCmpSource", { fg = colors.comment, italic = true })

  -- ── Documentation (background consistent with editor) ──
  set_hl("BlinkCmpDoc",             { bg = base_bg })
  set_hl("BlinkCmpDocBorder",       { fg = base_bg, bg = base_bg })
  set_hl("BlinkCmpDocSeparator",    { fg = colors.comment, bg = base_bg })
  set_hl("BlinkCmpDocCursorLine",   { bg = sel_bg })

  -- ── Signature (borderless: background matches editor, removes visual border) ──
  set_hl("BlinkCmpSignatureHelp",                { bg = base_bg })
  set_hl("BlinkCmpSignatureHelpBorder",          { fg = base_bg, bg = base_bg })
  set_hl("BlinkCmpSignatureHelpActiveParameter", { fg = colors.func, bold = true })

  -- ── Kind icons: each kind gets its own semantic color ──
  -- Default kind
  set_hl("BlinkCmpKind", { fg = colors.special })

  -- Functions / Methods — blue
  set_hl("BlinkCmpKindFunction",    { fg = colors.func })
  set_hl("BlinkCmpKindMethod",      { fg = colors.func })
  set_hl("BlinkCmpKindConstructor", { fg = colors.func })

  -- Types / Classes — purple
  set_hl("BlinkCmpKindClass",         { fg = colors.type })
  set_hl("BlinkCmpKindInterface",     { fg = colors.type })
  set_hl("BlinkCmpKindStruct",        { fg = colors.type })
  set_hl("BlinkCmpKindEnum",          { fg = colors.type })
  set_hl("BlinkCmpKindTypeParameter", { fg = colors.type })

  -- Variables / Fields — cyan
  set_hl("BlinkCmpKindVariable", { fg = colors.special })
  set_hl("BlinkCmpKindField",    { fg = colors.special })
  set_hl("BlinkCmpKindProperty", { fg = colors.special })

  -- Constants / Values — orange/yellow
  set_hl("BlinkCmpKindConstant",   { fg = colors.constant })
  set_hl("BlinkCmpKindValue",      { fg = colors.constant })
  set_hl("BlinkCmpKindEnumMember", { fg = colors.constant })
  set_hl("BlinkCmpKindUnit",       { fg = colors.constant })

  -- Keywords / Modules — violet
  set_hl("BlinkCmpKindKeyword",   { fg = colors.keyword })
  set_hl("BlinkCmpKindModule",    { fg = colors.keyword })
  set_hl("BlinkCmpKindNamespace", { fg = colors.keyword })

  -- Strings / Text — green
  set_hl("BlinkCmpKindText",    { fg = colors.string })
  set_hl("BlinkCmpKindSnippet", { fg = colors.string })

  -- Files / Paths — info blue
  set_hl("BlinkCmpKindFile",      { fg = colors.info })
  set_hl("BlinkCmpKindFolder",    { fg = colors.info })
  set_hl("BlinkCmpKindReference", { fg = colors.info })

  -- Events / Operators — red/pink
  set_hl("BlinkCmpKindEvent",    { fg = colors.error })
  set_hl("BlinkCmpKindOperator", { fg = colors.error })

  -- Colors
  set_hl("BlinkCmpKindColor", { fg = colors.constant })

  -- Ghost text
  set_hl("BlinkCmpGhostText", { fg = colors.comment, italic = true })
end

-- Apply all highlights
local function setup_all_highlights()
  setup_telescope_highlights()
  setup_misc_highlights()
  setup_multicursor_highlights()
  setup_symbol_usage_highlights()
  setup_dropbar_highlights()
  setup_blink_highlights()
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

-- ╭────────────────────────────────────────────────────────╮
-- │                    Plugin Config                       │
-- ╰────────────────────────────────────────────────────────╯

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
