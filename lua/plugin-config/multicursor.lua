local keys = require("keybindings")
local mc = require("multicursor-nvim")

mc.setup()

local set = vim.keymap.set

-- 添加或跳过主光标上方/下方的光标
set({"n", "x"}, keys.multicursor.addCursorAbove, function() mc.lineAddCursor(-1) end)
set({"n", "x"}, keys.multicursor.addCursorBelow, function() mc.lineAddCursor(1) end)
set({"n", "x"}, keys.multicursor.skipCursorAbove, function() mc.lineSkipCursor(-1) end)
set({"n", "x"}, keys.multicursor.skipCursorBelow, function() mc.lineSkipCursor(1) end)

-- 通过匹配单词/选择添加或跳过添加新光标
set({"n", "x"}, keys.multicursor.addNextMatch, function() mc.matchAddCursor(1) end)
set({"n", "x"}, keys.multicursor.skipNextMatch, function() mc.matchSkipCursor(1) end)
set({"n", "x"}, keys.multicursor.addPrevMatch, function() mc.matchAddCursor(-1) end)
set({"n", "x"}, keys.multicursor.skipPrevMatch, function() mc.matchSkipCursor(-1) end)

-- 使用 control + 左键点击添加和移除光标
set("n", keys.multicursor.addCursorWithMouse, mc.handleMouse)
set("n", "<c-leftdrag>", mc.handleMouseDrag)
set("n", "<c-leftrelease>", mc.handleMouseRelease)

-- 禁用和启用光标
set({"n", "x"}, keys.multicursor.toggleCursor, mc.toggleCursor)

-- 在 keymap layer 中定义的映射仅在有多个光标时生效
-- 这让你可以拥有重叠的映射
mc.addKeymapLayer(function(layerSet)

    -- 选择不同的光标作为主光标
    layerSet({"n", "x"}, keys.multicursor.prevCursor, mc.prevCursor)
    layerSet({"n", "x"}, keys.multicursor.nextCursor, mc.nextCursor)

    -- 删除主光标
    layerSet({"n", "x"}, keys.multicursor.deleteCursor, mc.deleteCursor)

    -- 使用 escape 键启用和清除光标
    layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        else
            mc.clearCursors()
        end
    end)
end)

-- 高亮配置已移至 colorscheme.lua 统一管理
