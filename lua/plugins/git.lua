-- ╭──────────────────────────────────────────────────────────╮
-- │                      Git Related                          │
-- ╰──────────────────────────────────────────────────────────╯

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ gitsigns - Git Signs                                   │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup(require("plugin-config.gitsigns").opts)
    end,
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
    opts = {
      graph_style = "unicode",
      process_spinner = true,
    },
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
