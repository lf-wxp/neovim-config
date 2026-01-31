local status, bufferline = pcall(require, "bufferline")
if not status then
    vim.notify("bufferline not found")
  return
end

-- bufferline configuration
-- https://github.com/akinsho/bufferline.nvim#configuration
bufferline.setup({
  options = {
    -- Command to close Tab, using moll/vim-bbye's :Bdelete command here
    close_command = "Bdelete! %d",
    separator_style = "slant",
    numbers = "both",
    right_mouse_command = "Bdelete! %d",
    -- Sidebar configuration
    -- Leave space on the left for nvim-tree, display text File Explorer
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
    indicator = {
      style = "underline"
    },
    -- Use nvim built-in LSP, will be configured in subsequent lessons
    diagnostics = "nvim_lsp",
    -- Optional, display LSP error icons
    ---@diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and "  " or (e == "warning" and "  " or "  ")
        s = s .. n .. sym
      end
      return s
    end,
  },
})
