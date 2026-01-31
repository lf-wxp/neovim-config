local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("telescope not found")
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
    -- Initial mode when opening popup, default is insert, can also be normal
    initial_mode = "insert",
    -- Window keymaps
    mappings = {
      n = { s = flash },
      i = {
        -- Move up/down
        ["<Down>"] = "move_selection_next",
        ["<Up>"] = "move_selection_previous",
        -- History navigation
        ["<C-n>"] = "cycle_history_next",
        ["<C-p>"] = "cycle_history_prev",
        -- Close window
        ["<C-c>"] = "close",
        -- Preview window scroll
        ["<leader>u"] = "preview_scrolling_up",
        ["<leader>d"] = "preview_scrolling_down",

        ["<leader>s"] = flash,
      },
    },
    borderchars = {
      prompt  = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
      results = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
      preview = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
    },
  },
  pickers = {
    -- Built-in pickers config
    find_files = {
      -- Change theme for find files, supported: dropdown, cursor, ivy
      -- theme = "ivy",
    },
    live_grep = {},
    marks = {},
    borderchars = {
      prompt  = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
      results = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
      preview = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        -- even more opts
      }),
    },
    -- Extension plugins config
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
      borderchars = {
        prompt  = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
        results = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
        preview = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
      },
    },
  },
})
-- telescope extensions
pcall(telescope.load_extension, "env")

pcall(telescope.load_extension, "ui-select")

pcall(telescope.load_extension, "symbols")

pcall(telescope.load_extension, "live_grep_args")

pcall(telescope.load_extension, "file_browser")

pcall(telescope.load_extension, "projects")
