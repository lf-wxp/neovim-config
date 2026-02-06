-- ╭──────────────────────────────────────────────────────────╮
-- │                    Lualine Configuration                 │
-- ╰──────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local status, Harpoonline = pcall(require, "harpoonline")
  if not status then
    vim.notify("harpoonline not found", vim.log.levels.ERROR)
    return
  end

  Harpoonline.setup({
    on_update = function() require("lualine").refresh() end,
  })

  require("lualine").setup({
    options = {
      theme = "auto",
      globalstatus = true,
      component_separators = { left = "/", right = "/" },
      section_separators = { left = " ", right = "" },
    },
    extensions = { "nvim-tree" },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        {
          "diff",
          colored = true,
          symbols = { added = " ", modified = " ", removed = " " },
          diff_color = {
            added = { fg = "#98be65" },
            modified = { fg = "#ECBE7B" },
            removed = { fg = "#ec5f67" },
          },
        },
        { "diagnostics", color = "Error" },
      },
      lualine_c = {
        { Harpoonline.format, color = "Operator" },
        { "filename", path = 1, file_status = true, color = "Boolean" },
        {
          "lsp_progress",
          spinner_symbols = { " ", " ", " ", " ", " ", " " },
        },
        { require("recorder").displaySlots, color = "Todo" },
        { require("recorder").recordingStatus, color = "Tag" },
      },
      lualine_x = {
        { "filesize", color = "Operator" },
        {
          "fileformat",
          symbols = {
            unix = "LF",
            dos = "CRLF",
            mac = "CR",
          },
          color = "Special",
        },
        { "encoding", color = "Type" },
        { "filetype", color = "String" },
      },
    },
  })
end

return M
