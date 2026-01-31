-- 配色方案和统一高亮配置
local M = {}

local colorscheme = "zephyr"
-- 备选: zephyr, nord, gruvbox, kanagawa, catppuccin

-- 加载配色方案
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
  return
end

-- 统一的颜色获取工具函数
local function get_hl(name)
  return vim.api.nvim_get_hl(0, { name = name })
end

local function set_hl(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

-- =====================================================
-- 自定义高亮配置（集中管理）
-- =====================================================

local function setup_telescope_highlights()
  local hl_groups = {
    TelescopePreviewNormal = { bg = '#2E323C' },
    TelescopePreviewBorder = { bg = '#2E323C' },
    TelescopeResultsNormal = { bg = '#23272e' },
    TelescopeResultsBorder = { bg = '#23272e' },
  }
  for name, opts in pairs(hl_groups) do
    set_hl(name, opts)
  end
end

local function setup_misc_highlights()
  -- BufferManager 修改标记
  set_hl("BufferManagerModified", { fg = "#0000af" })
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
  local cursor_bg = get_hl('CursorLine').bg
  local comment_fg = get_hl('Comment').fg
  local func_fg = get_hl('Function').fg
  local type_fg = get_hl('Type').fg
  local keyword_fg = get_hl('@keyword').fg

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

  -- 优先使用 Normal 的背景色适配主题，如果是透明背景则保持透明
  -- 不要使用 WinBar 默认的黑色背景
  local bg = normal_hl.bg  -- 可能是 nil（透明）或具体颜色值

  local colors = {
    normal_fg = normal_hl.fg,
    normal_bg = bg,  -- nil 时 nvim_set_hl 会忽略 bg，保持透明
    comment_fg = get_hl("Comment").fg,
    string_fg = get_hl("String").fg,
    func_fg = get_hl("Function").fg,
    type_fg = get_hl("Type").fg,
    keyword_fg = get_hl("Keyword").fg,
    constant_fg = get_hl("Constant").fg,
    special_fg = get_hl("Special").fg,
    separator_fg = get_hl("NonText").fg or get_hl("Comment").fg,
  }

  -- Winbar 基础
  set_hl("WinBar", { fg = colors.normal_fg, bg = colors.normal_bg })
  set_hl("WinBarNC", { fg = colors.comment_fg, bg = colors.normal_bg })
  set_hl("DropBarCurrentContext", { fg = colors.normal_fg, bg = colors.normal_bg, bold = true })
  set_hl("DropBarHover", { fg = colors.func_fg, bg = colors.normal_bg, bold = true })
  set_hl("DropBarIconUISeparator", { fg = colors.separator_fg, bg = colors.normal_bg })
  set_hl("DropBarIconUISeparatorActive", { fg = colors.func_fg, bg = colors.normal_bg })

  -- 路径
  set_hl("DropBarIconKindFolder", { fg = colors.keyword_fg, bg = colors.normal_bg })
  set_hl("DropBarIconKindFile", { fg = colors.string_fg, bg = colors.normal_bg })
  set_hl("DropBarKindFolder", { fg = colors.keyword_fg, bg = colors.normal_bg })
  set_hl("DropBarKindFile", { fg = colors.string_fg, bg = colors.normal_bg })

  -- 类型
  local type_kinds = { "Class", "Struct", "Interface", "Enum" }
  for _, kind in ipairs(type_kinds) do
    set_hl("DropBarIconKind" .. kind, { fg = colors.type_fg, bg = colors.normal_bg })
    set_hl("DropBarKind" .. kind, { fg = colors.type_fg, bg = colors.normal_bg })
  end
  set_hl("DropBarIconKindEnumMember", { fg = colors.constant_fg, bg = colors.normal_bg })
  set_hl("DropBarKindEnumMember", { fg = colors.constant_fg, bg = colors.normal_bg })

  -- 函数/方法
  local func_kinds = { "Function", "Method", "Constructor" }
  for _, kind in ipairs(func_kinds) do
    set_hl("DropBarIconKind" .. kind, { fg = colors.func_fg, bg = colors.normal_bg })
    set_hl("DropBarKind" .. kind, { fg = colors.func_fg, bg = colors.normal_bg })
  end

  -- 变量
  local var_kinds = { "Variable", "Field", "Property" }
  for _, kind in ipairs(var_kinds) do
    set_hl("DropBarIconKind" .. kind, { fg = colors.normal_fg, bg = colors.normal_bg })
    set_hl("DropBarKind" .. kind, { fg = colors.normal_fg, bg = colors.normal_bg })
  end

  -- 常量
  set_hl("DropBarIconKindConstant", { fg = colors.constant_fg, bg = colors.normal_bg })
  set_hl("DropBarIconKindString", { fg = colors.string_fg, bg = colors.normal_bg })
  set_hl("DropBarIconKindNumber", { fg = colors.constant_fg, bg = colors.normal_bg })
  set_hl("DropBarIconKindBoolean", { fg = colors.constant_fg, bg = colors.normal_bg })
  set_hl("DropBarKindConstant", { fg = colors.constant_fg, bg = colors.normal_bg })
  set_hl("DropBarKindString", { fg = colors.string_fg, bg = colors.normal_bg })
  set_hl("DropBarKindNumber", { fg = colors.constant_fg, bg = colors.normal_bg })
  set_hl("DropBarKindBoolean", { fg = colors.constant_fg, bg = colors.normal_bg })

  -- 其他
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

-- =====================================================
-- 应用所有高亮配置
-- =====================================================

function M.setup_all_highlights()
  setup_telescope_highlights()
  setup_misc_highlights()
  setup_multicursor_highlights()
  setup_symbol_usage_highlights()
  setup_dropbar_highlights()
end

-- 初始应用
M.setup_all_highlights()

-- 统一的自动命令组
local augroup = vim.api.nvim_create_augroup("ColorSchemeHighlights", { clear = true })

-- 主题切换时重新应用
vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.defer_fn(M.setup_all_highlights, 10)
  end,
})

-- 启动完成后应用（只需一次延迟即可）
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup,
  callback = function()
    vim.defer_fn(M.setup_all_highlights, 100)
  end,
})

return M
