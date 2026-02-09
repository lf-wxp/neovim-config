-- ╭────────────────────────────────────────────────────────╮
-- │       gitsigns.nvim - Git Signs Configuration          │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local keys = require("config.keymaps")
  local gs = require("gitsigns")

  local function on_attach(buffer)
    local gk = keys.gitsigns

    -- Don't attach gitsigns to floating windows
    if vim.api.nvim_win_get_config(0).relative ~= "" then
      return
    end

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
    end

    -- Navigation
    map("n", gk.next_hunk, function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, "Next Hunk")

    map("n", gk.prev_hunk, function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, "Prev Hunk")

    -- Actions
    map("n", gk.stage_hunk, gs.stage_hunk, "Stage Hunk")
    map("n", gk.stage_buffer, gs.stage_buffer, "Stage Buffer")
    map("n", gk.undo_stage_hunk, gs.undo_stage_hunk, "Undo Stage")
    map("n", gk.reset_hunk, gs.reset_hunk, "Reset Hunk")
    map("n", gk.reset_buffer, gs.reset_buffer, "Reset Buffer")
    map("n", gk.preview_hunk, gs.preview_hunk, "Preview Hunk")
    map("n", gk.blame_line, function() gs.blame_line({ full = true }) end, "Blame Line")
    map("n", gk.diffthis, gs.diffthis, "Diff This")
    map("n", gk.diff, function() gs.diffthis("~") end, "Diff All")
    map("n", gk.toggle_deleted, gs.toggle_deleted, "Toggle Deleted")
    map("n", gk.toggle_current_line_blame, gs.toggle_current_line_blame, "Toggle Line Blame")

    -- Text Object
    map({ "o", "x" }, gk.select_hunk, ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk")
  end

  gs.setup({
    signs = {
      add = { text = "+ ", },
      change = { text = "~ ", },
      delete = { text = "- ", },
      topdelete = { text = "↑ ", },
      changedelete = { text = "~ ", },
      untracked = { text = "? " },
    },
    -- Show icons
    signcolumn = true,     -- Toggle with `:Gitsigns toggle_signs`
    -- Line number highlight
    numhl = false,         -- Toggle with `:Gitsigns toggle_numhl`
    word_diff = false,     -- Toggle with `:Gitsigns toggle_word_diff`
    attach_to_untracked = true,
    current_line_blame = false, -- Controlled via toggle keymap
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 300,
      ignore_whitespace = false,
      use_focus = false, -- Disable focus mode to ensure blame always works
    },
    preview_config = {
      -- Options passed to nvim_open_win
      border = "solid",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    on_attach = on_attach,
  })
end

return M
