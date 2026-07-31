-- ╭────────────────────────────────────────────────────────╮
-- │                    Lualine Configuration               │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local Harpoonline = require("harpoonline")

  Harpoonline.setup({
    on_update = function() require("lualine").refresh() end,
  })

  -- LSP clients attached to the current buffer.
  -- Replaces the missing :LspInfo — shows which servers are active at a glance.
  local function lsp_clients()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if vim.tbl_isempty(clients) then
      return ""
    end
    local names = {}
    for _, client in ipairs(clients) do
      names[client.name] = true
    end
    local unique = vim.tbl_keys(names)
    table.sort(unique)
    return "󰒋 " .. table.concat(unique, ", ")
  end

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
        -- recorder wrapped in lazy function to preserve VeryLazy semantics
        { function() return require("recorder").displaySlots() end, color = "Todo" },
        { function() return require("recorder").recordingStatus() end, color = "Tag" },
      },
      lualine_x = {
        { lsp_clients, color = "Function" },
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
