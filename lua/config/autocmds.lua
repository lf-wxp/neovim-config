-- ╭────────────────────────────────────────────────────────╮
-- │                   Auto Commands                        │
-- │                                                        │
-- │ Purpose: Global autocommands for editor behavior       │
-- │ Note: Plugin-specific autocmds live in their own       │
-- │       config files (e.g. snacks.lua, lsp/common.lua)   │
-- ╰────────────────────────────────────────────────────────╯

local augroup = vim.api.nvim_create_augroup("UserAutoCommands", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Auto close nvim-tree: quit when only nvim-tree window remains
-- 兼容 sidebar 和 float 两种模式：
-- - sidebar 模式下检查非 float 窗口是否只剩 NvimTree
-- - float 模式下 nvim-tree 的 quit_on_open 已自动关闭，这里处理边缘情况
autocmd("BufEnter", {
  nested = true,
  group = augroup,
  callback = function()
    -- 分离 float 和非 float 窗口
    local non_float_wins = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(win).relative == "" then
        table.insert(non_float_wins, win)
      end
    end

    -- 当仅剩一个非 float 窗口且为 NvimTree 时退出
    if #non_float_wins == 1 then
      local buf = vim.api.nvim_win_get_buf(non_float_wins[1])
      if vim.bo[buf].filetype == "NvimTree" then
        vim.cmd("quit")
      end
    end
  end,
  desc = "Auto-quit when nvim-tree is last window",
})

-- Highlight on yank: handled by yanky.nvim (highlight.on_yank = true)
-- No need for manual TextYankPost autocmd here; yanky provides the same
-- flash feedback with configurable timer (see plugin-config/yanky.lua)

-- Don't continue comments on new line with o/O
-- 使用 FileType 事件：每个 buffer 仅在 filetype 检测时触发一次，比 BufEnter 更高效
autocmd("FileType", {
  group = augroup,
  callback = function()
    vim.opt_local.formatoptions = vim.opt_local.formatoptions
      - "o" -- O and o don't continue comments
      + "r" -- But Enter will continue
  end,
  desc = "Disable comment continuation on o/O",
})

-- Detect stdin input (used by auto-session to skip restore)
autocmd("StdinReadPre", {
  group = augroup,
  callback = function()
    vim.g.using_stdin = true
  end,
  desc = "Detect stdin for auto-session",
})

-- Auto-resize splits when terminal window is resized
autocmd("VimResized", {
  group = augroup,
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
  desc = "Auto-resize splits on terminal resize",
})

-- Detect external file changes and auto-reload
-- Triggers on focus gain, buffer enter, and cursor idle
-- 移除 CursorHoldI：插入模式空闲时不需要检测外部文件变更，减少不必要的 I/O
autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = augroup,
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
  desc = "Auto-detect external file changes",
})

-- Notify when file changes are detected externally
autocmd("FileChangedShellPost", {
  group = augroup,
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.INFO)
  end,
  desc = "Notify on external file change reload",
})

-- Restore cursor position when reopening a file
autocmd("BufReadPost", {
  group = augroup,
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Restore cursor position on file reopen",
})

-- Big file protection (fallback for snacks.bigfile)
-- snacks.bigfile 做主力处理（禁用 treesitter/LSP 等重量级功能）
-- 这里作为轻量级兜底，仅禁用 swap/undo 等基础设置，不清空 syntax/filetype
autocmd("BufReadPre", {
  group = augroup,
  callback = function(args)
    -- 如果 snacks.bigfile 已经处理过，跳过
    if vim.b[args.buf] and vim.b[args.buf].bigfile then
      return
    end
    local max_filesize = 1024 * 1024 -- 1 MB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > max_filesize then
      vim.b[args.buf].bigfile = true
      vim.opt_local.swapfile = false
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.undolevels = -1
      vim.opt_local.undoreload = 0
      vim.opt_local.list = false
      -- 注意：不清空 syntax/filetype，避免禁用所有插件检测
      -- snacks.bigfile 会负责禁用 treesitter highlight 等重量级功能
      vim.notify("Big file detected: swap/undo/list disabled", vim.log.levels.WARN)
    end
  end,
  desc = "Disable heavy features for big files (>1MB, fallback for snacks.bigfile)",
})
