-- ╭────────────────────────────────────────────────────────╮
-- │        nvim-treesitter - Syntax Highlight Config       │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local treesitter = require("nvim-treesitter.configs")

  require("nvim-treesitter.install").prefer_git = true

  treesitter.setup({
    sync_install = false,
    ensure_installed = {
      "json",
      "html",
      "css",
      "vim",
      "lua",
      "markdown",
      "markdown_inline",
      "javascript",
      "typescript",
      "tsx",
      "vue",
      "rust",
      "scss",
      "vimdoc",
      "regex",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = function(lang, bufnr)
        return vim.api.nvim_buf_line_count(bufnr) > 10000
      end,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<cr>",
        node_incremental = "<cr>",
        node_decremental = "<BS>",
        scope_incremental = "<TAB>",
      },
    },
    indent = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
  })
end

return M
