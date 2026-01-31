-- reactive.nvim config
-- Dynamically change cursor/cursorline style based on editing mode

require("reactive").setup({
  builtin = {
    cursorline = false,  -- Enable cursorline highlight
    cursor = true,      -- Enable cursor color
    modemsg = true,     -- Enable mode message color
  },
  -- Custom presets (optional)
  -- Use built-in presets, provides different colors for Normal/Insert/Visual modes
})
