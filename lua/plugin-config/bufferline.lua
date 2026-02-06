-- ╭──────────────────────────────────────────────────────────────🟢
-- │ bufferline.nvim - Tab Bar Configuration                    │
-- ╰──────────────────────────────────────────────────────────────🔴

---@module "plugin-config.bufferline"
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
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " 󰅘 " or (e == "warning" and " 󰀪 " or " 󰋽 ")
          s = s .. n .. sym
        end
        return s
      end,
    },
  })
end

return M
