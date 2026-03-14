-- ╭────────────────────────────────────────────────────────╮
-- │        nvim-treesitter - Syntax Highlight Config       │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

-- Languages to ensure installed
local ensure_installed = {
  "json",
  "jsonc",
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
  -- 补充常用语言（rust 生态需要 toml，配置文件需要 yaml/bash 等）
  "python",
  "toml",
  "yaml",
  "bash",
  "gitcommit",
  "diff",
  "dockerfile",
  "graphql",
}

M.setup = function()
  -- ── Treesitter Base Config ──
  -- New nvim-treesitter setup only accepts basic options like install_dir
  -- highlight / indent are built into Neovim core, no extra config needed
  require("nvim-treesitter").setup()

  -- ── Ensure Languages Installed ──
  local installed = require("nvim-treesitter.config").get_installed()
  local missing = vim.tbl_filter(function(lang)
    return not vim.list_contains(installed, lang)
  end, ensure_installed)

  if #missing > 0 then
    require("nvim-treesitter.install").install(missing)
  end

  -- ── Highlight Config ──
  -- Auto-enable treesitter highlighting for all files with a parser
  -- (Neovim 0.11 built-in ftplugin only enables for lua/help/query, others need manual enabling)
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
    callback = function(args)
      local bufnr = args.buf
      -- Skip treesitter highlighting for very large files
      local line_count = vim.api.nvim_buf_line_count(bufnr)
      if line_count > 10000 then
        return
      end
      -- Try enabling treesitter highlighting, silently fail if no parser available
      local ok = pcall(vim.treesitter.start, bufnr)
      if ok then
        -- Also enable treesitter indentation
        vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })

  -- ── Textobjects Config ──
  require("nvim-treesitter-textobjects").setup({
    select = {
      lookahead = true,
    },
    move = {
      set_jumps = true,
    },
  })

  -- ── Textobjects Select Mappings ──
  local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject
  local select_keymaps = {
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
  }
  for key, query in pairs(select_keymaps) do
    vim.keymap.set({ "x", "o" }, key, function()
      select_textobject(query)
    end, { desc = "Textobject: " .. query })
  end

  -- ── Textobjects Swap Mappings ──
  local swap = require("nvim-treesitter-textobjects.swap")
  local swap_keys = require("config.keymaps").treesitterSwap
  vim.keymap.set("n", swap_keys.swap_next, function()
    swap.swap_next("@parameter.inner")
  end, { desc = "Swap next parameter" })
  vim.keymap.set("n", swap_keys.swap_prev, function()
    swap.swap_previous("@parameter.inner")
  end, { desc = "Swap previous parameter" })

  -- ── Textobjects Move Mappings ──
  local move = require("nvim-treesitter-textobjects.move")
  local move_keymaps = {
    { "]m", move.goto_next_start, "@function.outer", "Next function start" },
    { "]]", move.goto_next_start, "@class.outer", "Next class start" },
    { "]M", move.goto_next_end, "@function.outer", "Next function end" },
    { "][", move.goto_next_end, "@class.outer", "Next class end" },
    { "[m", move.goto_previous_start, "@function.outer", "Prev function start" },
    { "[[", move.goto_previous_start, "@class.outer", "Prev class start" },
    { "[M", move.goto_previous_end, "@function.outer", "Prev function end" },
    { "[]", move.goto_previous_end, "@class.outer", "Prev class end" },
  }
  for _, map in ipairs(move_keymaps) do
    vim.keymap.set({ "n", "x", "o" }, map[1], function()
      map[2](map[3])
    end, { desc = map[4] })
  end

  -- ── Incremental Selection (treesitter node-based) ──
  local current_node = nil

  -- 不应覆盖 <CR> 的特殊 buffer 类型
  local cr_excluded_ft = {
    "qf", "help", "man", "lspinfo", "spectre_panel", "NvimTree",
    "TelescopePrompt", "TelescopeResults", "Trouble", "toggleterm",
    "DressingSelect", "lazy", "mason", "noice", "notify",
  }

  -- Initialize / expand selection
  vim.keymap.set({ "n", "x" }, "<CR>", function()
    -- 在特殊窗口中，保留 <CR> 原生行为
    local ft = vim.bo.filetype
    if vim.tbl_contains(cr_excluded_ft, ft) or vim.bo.buftype ~= "" then
      return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
    end

    local node = current_node
    if not node then
      node = vim.treesitter.get_node()
    else
      node = node:parent()
    end
    if not node then
      return
    end
    current_node = node
    local sr, sc, er, ec = node:range()
    -- Enter visual mode and select node range
    vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
    vim.cmd("normal! v")
    vim.api.nvim_win_set_cursor(0, { er + 1, math.max(0, ec - 1) })
  end, { desc = "Incremental selection (expand)" })

  -- Shrink selection
  vim.keymap.set("x", "<BS>", function()
    if current_node then
      local child = current_node:child(0)
      if child then
        current_node = child
      else
        -- No child node, go back to node at cursor position
        current_node = vim.treesitter.get_node()
      end
    else
      current_node = vim.treesitter.get_node()
    end
    if not current_node then
      return
    end
    local sr, sc, er, ec = current_node:range()
    vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
    vim.cmd("normal! v")
    vim.api.nvim_win_set_cursor(0, { er + 1, math.max(0, ec - 1) })
  end, { desc = "Incremental selection (shrink)" })

  -- Reset state when leaving visual mode
  vim.api.nvim_create_autocmd("ModeChanged", {
    group = vim.api.nvim_create_augroup("treesitter_incremental_selection", { clear = true }),
    pattern = "[vV\x16]*:n",
    callback = function()
      current_node = nil
    end,
  })
end

return M
