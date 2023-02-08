-- 如果找不到lualine 组件，就不继续执行
local status, lualine = pcall(require, "lualine")
if not status then
  vim.notify("没有找到 lualine")
  return
end

lualine.setup({
  options = {
    -- theme = "edge",
    theme = "auto",
    component_separators = { left = "/", right = "/" },
    -- https://github.com/ryanoasis/powerline-extra-symbols
    section_separators = { left = " ", right = "" },
  },
  extensions = { "nvim-tree", "toggleterm" },
  sections = {
    lualine_a = {
      "mode"
    },
    lualine_b = {
      "branch",
      {
        "diff",
        -- Is it me or the symbol for modified us really weird
        symbols = { added = " ", modified = "柳", removed = " " },
        diff_color = {
          added = { fg = "#98be65" },
          modified = { fg = "#ECBE7B" },
          removed = { fg = "#ec5f67" },
        },
      },
      "diagnostics"
    },
    lualine_c = {
      { "filename", path = 1, file_status  = true },
      {
        "lsp_progress",
        spinner_symbols = { " ", " ", " ", " ", " ", " " },
      },
      require("auto-session-library").current_session_name,
    },
    lualine_x = {
      "filesize",
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
      },
      "encoding",
      "filetype",
    },
  },
})
