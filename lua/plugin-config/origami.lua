-- ╭────────────────────────────────────────────────────────╮
-- │          nvim-origami - Smart Code Folding Config      │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local origami = require("origami")

  -- Set fold level to ensure files open unfolded
  vim.opt.foldlevel = 99
  vim.opt.foldlevelstart = 99
  vim.opt.foldenable = true
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.require'origami'.foldexpr()"

  origami.setup({
    useLspFoldsWithTreesitterFallback = {
      enabled = false,
    },
    rememberFolds = false,
    autoFold = {
      enabled = false,
      kinds = {},
    },
    foldtext = {
      enabled = false,
    },
    foldKeymaps = {
      setup = true,
      closeOnlyOnFirstColumn = false,
      scrollLeftOnCaret = false,
    },
  })

  -- Custom foldtext function
  local function custom_foldtext()
    local foldstart = vim.v.foldstart
    local foldend = vim.v.foldend
    local foldlevel = vim.v.foldlevel
    
    local first_line = vim.fn.getline(foldstart)
    first_line = first_line:match("^%s*(.-)$") or first_line
    local folded_lines = foldend - foldstart + 1
    
    local folder_icon = "󰘖"
    local code_icon = ""
    local lines_icon = "󰯌"
    local arrow_icon = ""
    local separator = "│"
    
    local indent = string.rep("  ", foldlevel - 1)
    local prefix = indent .. folder_icon .. " " .. code_icon .. " "
    local suffix = " " .. separator .. " " .. lines_icon .. " " .. folded_lines .. " " .. arrow_icon
    
    local win_width = vim.api.nvim_win_get_width(0)
    local prefix_len = vim.fn.strdisplaywidth(prefix)
    local suffix_len = vim.fn.strdisplaywidth(suffix)
    
    local max_content_width = 50
    local fixed_spacing = 1
    local content_width = math.min(max_content_width, win_width - prefix_len - suffix_len - fixed_spacing)
    if content_width < 10 then
      content_width = 10
    end
    
    local content = first_line
    if vim.fn.strdisplaywidth(content) > content_width then
      content = vim.fn.strcharpart(content, 0, content_width - 3) .. "..."
    end
    
    local content_actual_width = vim.fn.strdisplaywidth(content)
    local pad_len = content_width - content_actual_width
    if pad_len < 0 then pad_len = 0 end
    local padding = string.rep(" ", pad_len)
    
    return prefix .. content .. padding .. suffix
  end

  _G.custom_foldtext = custom_foldtext

  -- Defer foldtext setting
  vim.defer_fn(function()
    vim.opt.foldtext = "v:lua.custom_foldtext()"
  end, 100)

  -- Ensure foldtext is set on every buffer enter
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "FileType" }, {
    pattern = "*",
    callback = function()
      vim.defer_fn(function()
        vim.opt_local.foldtext = "v:lua.custom_foldtext()"
      end, 10)
    end,
    desc = "Ensure custom foldtext is set",
  })
end

return M
