-- ╭──────────────────────────────────────────────────────────╮
-- │        nvim-treesitter - Syntax Highlight Config          │
-- ╰──────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local status, treesitter = pcall(require, "nvim-treesitter.configs")
  if not status then
    vim.notify("nvim-treesitter not found", vim.log.levels.ERROR)
    return
  end

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
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = 1000,
      colors = {
        "#95ca60",
        "#ee6985",
        "#D6A760",
        "#7794f4",
        "#b38bf5",
        "#7cc7fe",
      },
    },
    refactor = {
      highlight_definitions = {
        enable = true,
        clear_on_cursor_move = true,
      },
      highlight_current_scope = { enable = true },
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
