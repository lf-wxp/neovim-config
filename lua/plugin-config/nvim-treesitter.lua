-- ╭────────────────────────────────────────────────────────╮
-- │        nvim-treesitter - Syntax Highlight Config       │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

-- 需要确保安装的语言列表
local ensure_installed = {
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
}

M.setup = function()
  -- ── Treesitter 基础配置 ──
  -- 新版 nvim-treesitter 的 setup 仅接受 install_dir 等基础选项
  -- highlight / indent 已内置于 Neovim 核心，无需额外配置
  require("nvim-treesitter").setup()

  -- ── 确保语言已安装 ──
  local installed = require("nvim-treesitter.config").get_installed()
  local missing = vim.tbl_filter(function(lang)
    return not vim.list_contains(installed, lang)
  end, ensure_installed)

  if #missing > 0 then
    require("nvim-treesitter.install").install(missing)
  end

  -- ── 高亮配置 ──
  -- 为所有有 treesitter parser 的文件自动启用高亮
  -- （Neovim 0.11 内置 ftplugin 只对 lua/help/query 启用，其他语言需手动启用）
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
    callback = function(args)
      local bufnr = args.buf
      -- 超大文件不启用 treesitter 高亮
      local line_count = vim.api.nvim_buf_line_count(bufnr)
      if line_count > 10000 then
        return
      end
      -- 尝试启用 treesitter 高亮，如果没有对应 parser 则静默失败
      local ok = pcall(vim.treesitter.start, bufnr)
      if ok then
        -- 同时启用 treesitter 缩进
        vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })

  -- ── Textobjects 配置 ──
  require("nvim-treesitter-textobjects").setup({
    select = {
      lookahead = true,
    },
    move = {
      set_jumps = true,
    },
  })

  -- ── Textobjects 选择映射 ──
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

  -- ── Textobjects 交换映射 ──
  local swap = require("nvim-treesitter-textobjects.swap")
  vim.keymap.set("n", "<leader>a", function()
    swap.swap_next("@parameter.inner")
  end, { desc = "Swap next parameter" })
  vim.keymap.set("n", "<leader>A", function()
    swap.swap_previous("@parameter.inner")
  end, { desc = "Swap previous parameter" })

  -- ── Textobjects 移动映射 ──
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

  -- ── 增量选择（基于 treesitter 节点） ──
  local current_node = nil

  -- 初始化/扩大选择
  vim.keymap.set({ "n", "x" }, "<CR>", function()
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
    -- 进入可视模式并选中节点范围
    vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
    vim.cmd("normal! v")
    vim.api.nvim_win_set_cursor(0, { er + 1, math.max(0, ec - 1) })
  end, { desc = "Incremental selection (expand)" })

  -- 缩小选择
  vim.keymap.set("x", "<BS>", function()
    if current_node then
      local child = current_node:child(0)
      if child then
        current_node = child
      else
        -- 没有子节点，回到当前节点光标位置的节点
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

  -- 离开可视模式时重置状态
  vim.api.nvim_create_autocmd("ModeChanged", {
    group = vim.api.nvim_create_augroup("treesitter_incremental_selection", { clear = true }),
    pattern = "[vV\x16]*:n",
    callback = function()
      current_node = nil
    end,
  })
end

return M
