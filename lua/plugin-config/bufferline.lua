-- ╭────────────────────────────────────────────────────────╮
-- │       bufferline.nvim - Tab Bar Configuration          │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  require("bufferline").setup({
    options = {
      close_command = "Bdelete! %d",
      separator_style = "slant",
      numbers = "both",
      right_mouse_command = "Bdelete! %d",
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
      indicator = { style = "underline" },
      diagnostics = "nvim_lsp",
      ---@param diagnostics_dict table<string, integer>
      ---@param context {buffer: integer}
      diagnostics_indicator = function(_, _, diagnostics_dict, context)
        -- 非当前 buffer 只显示 error 级别，减少视觉干扰
        if context.buffer:current() then
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " 󰅘 " or (e == "warning" and " 󰀪 " or " 󰋽 ")
            s = s .. n .. sym
          end
          return s
        end
        -- 非当前 buffer：仅显示 error
        local errors = diagnostics_dict["error"]
        return errors and (" " .. errors .. " 󰅘 ") or ""
      end,
    },
  })
end

return M
