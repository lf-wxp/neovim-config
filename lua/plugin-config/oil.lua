-- oil.nvim config - Edit filesystem as buffer
local oil = require("oil")

oil.setup({
  -- Default file explorer
  default_file_explorer = false, -- Keep nvim-tree as default

  -- Column display
  columns = {
    "icon",
    -- "permissions",
    "size",
    -- "mtime",
  },

  -- Buffer options
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },

  -- Window options
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
  },

  -- Delete to trash
  delete_to_trash = true,

  -- Skip confirm for simple edits
  skip_confirm_for_simple_edits = true,

  -- Prompt save on select new entry
  prompt_save_on_select_new_entry = true,

  -- Cleanup cache
  cleanup_delay_ms = 2000,

  -- LSP file operations support
  lsp_file_methods = {
    timeout_ms = 1000,
    autosave_changes = false,
  },

  -- Constrain cursor to filename column
  constrain_cursor = "editable",

  -- watch_for_changes = false,

  -- Keymaps
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },

  -- Use default keymaps
  use_default_keymaps = true,

  -- View options
  view_options = {
    show_hidden = true,
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    is_always_hidden = function(name, bufnr)
      return false
    end,
    natural_order = true,
    sort = {
      { "type", "asc" },
      { "name", "asc" },
    },
  },

  -- Float window config
  float = {
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = "solid",
    win_options = {
      winblend = 0,
    },
  },

  -- Preview window config
  preview = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = 0.9,
    min_height = { 5, 0.1 },
    height = nil,
    border = "solid",
    win_options = {
      winblend = 0,
    },
    update_on_cursor_moved = true,
  },

  -- Progress bar config
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = "solid",
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
})

-- Keymaps have been unified in keymaps.lua
