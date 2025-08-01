-- 如果找不到lualine 组件，就不继续执行
local status, lualine = pcall(require, "lualine")
if not status then
  vim.notify("没有找到 lualine")
  return
end

local Harpoonline = require("harpoonline")
Harpoonline.setup({
  on_update = function() require("lualine").refresh() end,
})

lualine.setup({
  options = {
    -- theme = "edge",
    theme = "auto",
    globalstatus = true,
    component_separators = { left = "/", right = "/" },
    -- https://github.com/ryanoasis/powerline-extra-symbols
    section_separators = { left = " ", right = "" },
  },
  extensions = { "nvim-tree", "toggleterm" },
  sections = {
    lualine_a = {
      "mode",
    },
    lualine_b = {
      "branch",
      {
        "diff",
        colored = true, -- displays a colored diff status if set to true
        -- Is it me or the symbol for modified us really weird
        symbols = { added = " ", modified = "柳", removed = " " },
        diff_color = {
          added = { fg = "#98be65" },
          modified = { fg = "#ECBE7B" },
          removed = { fg = "#ec5f67" },
        },
      },
      { "diagnostics", color = "Error" }
    },
    lualine_c = {
      { Harpoonline.format, color = "Operator" },
      { "filename",         path = 1,          file_status = true, color = "Boolean" },
      {
        "lsp_progress",
        spinner_symbols = { " ", " ", " ", " ", " ", " " },
      },
      -- { require("auto-session.lib").current_session_name, color = "Constant" },
      { require("recorder").displaySlots,                 color = "Todo" },
      { require("recorder").recordingStatus,              color = "Tag" },
    },
    lualine_x = {
      { "filesize", color = "Operator" },
      {
        "fileformat",
        -- symbols = {
        --   unix = '', -- e712
        --   dos = '', -- e70f
        --   mac = '', -- e711
        -- },
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
