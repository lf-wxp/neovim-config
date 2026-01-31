local keys = require("config.keymaps")
local mc = require("multicursor-nvim")

mc.setup()

local set = vim.keymap.set
local opts = function(desc) return { noremap = true, silent = true, desc = desc } end

-- Add or skip cursor above/below main cursor
set({"n", "x"}, keys.multicursor.addCursorAbove, function() mc.lineAddCursor(-1) end, opts("Add Cursor Above"))
set({"n", "x"}, keys.multicursor.addCursorBelow, function() mc.lineAddCursor(1) end, opts("Add Cursor Below"))
set({"n", "x"}, keys.multicursor.skipCursorAbove, function() mc.lineSkipCursor(-1) end, opts("Skip Cursor Above"))
set({"n", "x"}, keys.multicursor.skipCursorBelow, function() mc.lineSkipCursor(1) end, opts("Skip Cursor Below"))

-- Add or skip new cursor by matching word/selection
set({"n", "x"}, keys.multicursor.addNextMatch, function() mc.matchAddCursor(1) end, opts("Add Cursor Next Match"))
set({"n", "x"}, keys.multicursor.skipNextMatch, function() mc.matchSkipCursor(1) end, opts("Skip Cursor Next Match"))
set({"n", "x"}, keys.multicursor.addPrevMatch, function() mc.matchAddCursor(-1) end, opts("Add Cursor Prev Match"))
set({"n", "x"}, keys.multicursor.skipPrevMatch, function() mc.matchSkipCursor(-1) end, opts("Skip Cursor Prev Match"))

-- Use control + left click to add and remove cursors
set("n", keys.multicursor.addCursorWithMouse, mc.handleMouse, opts("Add Cursor With Mouse"))
set("n", "<c-leftdrag>", mc.handleMouseDrag, opts("Cursor Mouse Drag"))
set("n", "<c-leftrelease>", mc.handleMouseRelease, opts("Cursor Mouse Release"))

-- Toggle cursor
set({"n", "x"}, keys.multicursor.toggleCursor, mc.toggleCursor, opts("Toggle Cursor"))

-- Keymaps only work when there are multiple cursors
mc.addKeymapLayer(function(layerSet)

    -- Select different cursor as main cursor
    layerSet({"n", "x"}, keys.multicursor.prevCursor, mc.prevCursor)
    layerSet({"n", "x"}, keys.multicursor.nextCursor, mc.nextCursor)

    -- Delete main cursor
    layerSet({"n", "x"}, keys.multicursor.deleteCursor, mc.deleteCursor)

    -- Use escape to enable and clear cursors
    layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        else
            mc.clearCursors()
        end
    end)
end)

-- Highlight config moved to colorscheme.lua for unified management
