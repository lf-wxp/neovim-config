-- ╭──────────────────────────────────────────────────────────╮
-- │                 Telescope Configuration                 │
-- ╰──────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local status, telescope = pcall(require, "telescope")
  if not status then
    vim.notify("telescope not found", vim.log.levels.ERROR)
    return
  end

  local function flash(prompt_bufnr)
    require("flash").jump({
      pattern = "^",
      label = { after = { 0, 0 } },
      search = {
        mode = "search",
        exclude = {
          function(win)
            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
          end,
        },
      },
      action = function(match)
        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
        picker:set_selection(match.pos[1] - 1)
      end,
    })
  end

  telescope.setup({
    defaults = {
      winblend = 20,
      initial_mode = "insert",
      mappings = {
        n = { s = flash },
        i = {
          ["<Down>"] = "move_selection_next",
          ["<Up>"] = "move_selection_previous",
          ["<C-n>"] = "cycle_history_next",
          ["<C-p>"] = "cycle_history_prev",
          ["<C-c>"] = "close",
          ["<leader>u"] = "preview_scrolling_up",
          ["<leader>d"] = "preview_scrolling_down",
          ["<leader>s"] = flash,
        },
      },
      borderchars = {
        prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
        results = { " ", " ", " ", " ", " ", " ", " ", " " },
        preview = { " ", " ", " ", " ", " ", " ", " ", " " },
      },
    },
    pickers = {
      find_files = {},
      live_grep = {},
      marks = {},
      borderchars = {
        prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
        results = { " ", " ", " ", " ", " ", " ", " ", " " },
        preview = { " ", " ", " ", " ", " ", " ", " ", " " },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      frecency = {
        show_scores = true,
        show_unindexed = true,
        ignore_patterns = { "*.git/*", "*/tmp/*" },
        disable_devicons = false,
        workdirs = {
          ["/Users/franciscowu/.config/nvim"] = "nvim",
        },
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
      file_browser = {
        theme = "ivy",
        hijack_netrw = true,
        mappings = { i = {}, n = {} },
        borderchars = {
          prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
          results = { " ", " ", " ", " ", " ", " ", " ", " " },
          preview = { " ", " ", " ", " ", " ", " ", " ", " " },
        },
      },
    },
  })

  -- Load extensions safely
  local extensions = {
    "fzf",
    "frecency",
    "env",
    "ui-select",
    "symbols",
    "live_grep_args",
    "file_browser",
    "projects",
    "session-lens",
  }

  for _, ext in ipairs(extensions) do
    pcall(telescope.load_extension, ext)
  end
end

return M
