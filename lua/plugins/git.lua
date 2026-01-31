-- ╭──────────────────────────────────────────────────────────╮
-- │                      Git Related                          │
-- ╰──────────────────────────────────────────────────────────╯

local keys = require("config.keymaps")

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ gitsigns - Git Signs                                   │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = require("gitsigns")
        local gk = keys.gitsigns

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
      end,
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ neogit - Git Interface                                 │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("plugin-config.neogit")
    end,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ diffview - Diff View                                   │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugin-config.diffview")
    end,
  },
}
