vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function keymap(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- 插件快捷键
local pluginKeys = {}

-- 取消 s 默认功能
-- windows 分屏快捷键
keymap("n", "<leader>sv", ":vsp<cr>", "windows split vertical")
keymap("n", "<leader>sh", ":sp<cr>", "windows split horizontal")
-- 关闭当前
keymap("n", "<leader>sc", "<C-w>c", "windows close")
-- 关闭其他
keymap("n", "<leader>so", "<C-w>o", "windows close other")
-- Alt + hjkl  窗口之间跳转
keymap("n", "<leader>wh", "<C-w>h", "windows pop left")
keymap("n", "<leader>wj", "<C-w>j", "windows pop up")
keymap("n", "<leader>wk", "<C-w>k", "windows pop down")
keymap("n", "<leader>wl", "<C-w>l", "windows pop left")

-- 左右比例控制
keymap("n", "<leader>shh", ":vertical resize -10<cr>", "resize vertical -10")
keymap("n", "<leader>sll", ":vertical resize +10<cr>", "resize vertical +10")
-- 上下比例
keymap("n", "<leader>sjj", ":resize +10<cr>", "resize horizontal +10")
keymap("n", "<leader>skk", ":resize -10<cr>", "resize horizontal -10")
-- 等比例
keymap("n", "<leader>s=", "<C-w>=", "resize even")

-- visual模式下缩进代码
-- 上下移动选中文本
keymap("v", "J", ":move '>+1<cr>gv-gv", "visual move down")
keymap("v", "K", ":move '<-2<cr>gv-gv", "visual move up")

-- 上下滚动浏览
pluginKeys.neoscroll = {
  scroll_up = "<leader>u",
  scroll_down = "<leader>d",
}

-- nvim-tree
keymap("n", "<leader>tt", ":NvimTreeToggle<cr>", "tree")

-- bufferline
-- 左右Tab切换
keymap("n", "<leader>h", ":BufferLineCyclePrev<cr>", "tab left")
keymap("n", "<leader>l", ":BufferLineCycleNext<cr>", "tab right")
keymap("n", "<leader><", ":BufferLineMovePrev<cr>", "tab move left")
keymap("n", "<leader>>", ":BufferLineMoveNext<cr>", "tab move right")
keymap("n", "<leader>tp", ":BufferLinePick<cr>", "tab pick")
-- 关闭
--"moll/vim-bbye"
keymap("n", "<leader>tc", ":Bdelete!<cr>", "tab close")
keymap("n", "<leader>bcl", ":BufferLineCloseRight<cr>", "tab close right")
keymap("n", "<leader>bch", ":BufferLineCloseLeft<cr>", "tab close left")
keymap("n", "<leader>bc", ":BufferLinePickClose<cr>", "tab close pick")

-- Telescope
-- 查找文件
-- keymap("n", "<leader><leader>f", ":Telescope find_files<cr>", opt)
keymap("n", "<leader><leader>f", ":Telescope find_files<cr>", "find file")
-- 全局搜索
keymap("n", "<leader><leader>t", ":Telescope live_grep_args<cr>", "search text")
-- 全局session
-- keymap("n", "<leader><leader>s", ":Autosession search<cr>", "find session")
-- 全局project
keymap("n", "<leader><leader>p", ":Telescope projects<cr>", "find project")

keymap("n", "<leader><leader>c", ":Telescope colorscheme<cr>", "find colorscheme")

keymap("n", "<leader><leader>e", ":Telescope file_browser path=%:p:h select_buffer=true<cr>", "file browser")

-- lsp 捷键设置
pluginKeys.lsp = {
  -- rename
  -- rename = "<leader>rn",
  -- code action
  code_action = "<leader>ca",
  -- go xx
  go_definitiion = "gd",
  -- hover
  hover_doc = "gh",
  -- scroll down hover doc or scroll in definition preview
  hover_definition_scroll_up = "su",
  -- scroll up hover doc
  hover_definition_scroll_down = "sd",
  go_declaration = "gD",
  go_implementation = "gi",
  -- vim.lsp.buf.references()
  references = "gr",
  -- diagnostic
  line_diagnostics = "gp",
  next_diagnostics = "gj",
  prev_diagnostics = "gk",
  format = "==",
}


-- grug-far
-- 全项目替换
keymap("n", "<leader>rp", "<cmd>GrugFar<cr>", "find replace")
-- 只替换当前文件
keymap("n", "<leader>rf", "<cmd>lua require('grug-far').open({ prefills = { flags = vim.fn.expand('%') } })<cr>",
  "find current")
-- 全项目中搜索当前单词
keymap("n", "<leader>rw",
  "<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') }})<cr>",
  "find current word")


-- luasnip
pluginKeys.snip = {
  expand_jumpable = "<C-l>",
  jumpable = "<C-h>",
  choice_active_down = "<C-j>",
  choice_active_up = "<C-k>",
}

-- 代码注释插件
pluginKeys.comment = {
  -- Normal 模式快捷键
  toggler = {
    line = "gcc",  -- 行注释
    block = "gbc", -- 块注释
  },
  -- Visual 模式
  opleader = {
    line = "gc",
    bock = "gb",
  },
}

-- toggleTerm
-- 自定义 toggleterm 3个不同类型的命令行窗口
pluginKeys.toggleTerm = {
  -- <leader>tf 浮动
  float = "<leader>tf",
  -- <leader>tr 右侧
  right = "<leader>tr",
  -- <leader>td 下方
  bottom = "<leader>td",

  switch = "<Esc>"
}

-- gitsigns
pluginKeys.gitsigns = {
  next_hunk = "<leader>gj",
  prev_hunk = "<leader>gk",
  stage_hunk = "<leader>gs",
  stage_buffer = "<leader>gS",
  undo_stage_hunk = "<leader>gu",
  reset_hunk = "<leader>gr",
  reset_buffer = "<leader>gR",
  preview_hunk = "<leader>gp",
  blame_line = "<leader>gbl",
  diffthis = "<leader>gd",
  diff = "<leader>gD",
  toggle_deleted = "<leader>gtd",
  toggle_current_line_blame = "<leader>gtb",
  select_hunk = "<leader>ig",
}
-- flash
keymap({ "n", "x", "o" }, "<leader>f", "<cmd>lua require('flash').jump()<cr>", "flash whole")
keymap({ "n", "x", "o" }, "<leader>F", "<cmd>lua require('flash').treesitter_search()<cr>", "flash treesitter")
-- keymap("o", "<leader><leader>F", "<cmd>lua require('flash').remote()<cr>", "flash remote")
-- keymap({ "x", "o" }, "<leader>Fs", "<cmd>lua require('flash').treesitter_search()<cr>", opt)

-- Paste from clipboard
keymap({ "n", "v" }, "<leader>p", '"+p', "paste")
-- Copy to clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', "copy")


-- goto-preview
keymap("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", "preview definition")
keymap("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>", "preview implementation")
keymap("n", "gpc", "<cmd>lua require('goto-preview').close_all_win()<cr>", "preview close all")
keymap("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<cr>", "preview references")

-- harpoon
pluginKeys.harpoon = {
  append = "<leader>na",
  toggle = "<leader>nt",
  next = "<leader>nn",
  prev = "<leader>np",
  n1 = "<leader>n1",
  n2 = "<leader>n2",
  n3 = "<leader>n3",
  n4 = "<leader>n4",
  n5 = "<leader>n5",
  n6 = "<leader>n6",
}

-- crates
keymap("n", "<leader>ct", "<cmd>lua require('crates').toggle()<cr>", "crate toggle")
keymap("n", "<leader>cr", "<cmd>lua require('crates').reload()<cr>", "crate reload")
keymap("n", "<leader>cv", "<cmd>lua require('crates').show_versions_popup()<cr>", "crate vresion")
keymap("n", "<leader>cf", "<cmd>lua require('crates').show_features_popup()<cr>", "crate features")
keymap("n", "<leader>cd", "<cmd>lua require('crates').show_dependencies_popup()<cr>", "crate dependencies")
keymap("n", "<leader>cu", "<cmd>lua require('crates').update_crate()<cr>", "crate update")
keymap("n", "<leader>cU", "<cmd>lua require('crates').upgrade_crate()<cr>", "crate upgrade")
keymap("n", "<leader>cA", "<cmd>lua require('crates').upgrade_all_crates()<cr>", "crate upgrade all")
keymap("n", "<leader>cH", "<cmd>lua require('crates').open_homepage()<cr>", "crate homepage")
keymap("n", "<leader>cR", "<cmd>lua require('crates').open_repository()<cr>", "crate respository")
keymap("n", "<leader>cD", "<cmd>lua require('crates').open_documentation()<cr>", "crate document")
keymap("n", "<leader>cC", "<cmd>lua require('crates').open_crates_io()<cr>", "crate open io")

keymap("n", "<leader>k", ":noh<cr>", "dismiss highlight")


keymap("n", "<leader>o", "<C-o>", "navigate backward")
keymap("n", "<leader>i", "<C-i>", "navigate forward")

-- buffer_manager
keymap("n", "<leader><leader>b", "<cmd>lua require('buffer_manager.ui').toggle_quick_menu()<cr>", "buffer manager")

-- codeaction preview
keymap({ "v", "n" }, "<leader>ca", "<cmd>lua require('actions-preview').code_actions()<cr>", "code action")

-- multiple-cursors
keymap({ "n", "x" }, "<C-j>", "<cmd>MultipleCursorsAddDown<cr>", "add cursor and move down")
keymap({ "n", "x" }, "<C-k>", "<cmd>MultipleCursorsAddUp<cr>", "add cursor and move up")
keymap({ "n", "i" }, "<C-LeftMouse>", "<cmd>MultipleCursorsMouseAddDelete<cr>", "add or remove cursor")
keymap({ "n", "x" }, "<leader>mg", "<cmd>MultipleCursorsAddMatches<cr>", "add cursor to move down")
keymap({ "n", "x" }, "<leader>mG", "<cmd>MultipleCursorsAddMatchesV<cr>", "add cursors to cword in previous area")
keymap({ "n", "x" }, "<leader>mm", "<cmd>MultipleCursorsAddJumpNextMatch<cr>", "add cursor and jump to next cword")

-- neogit
keymap({ "n" }, "<leader>gg", "<cmd>Neogit<cr>", "open neogit")

-- treesj
keymap({ "n" }, "<leader>e", "<cmd>lua require('treesj').toggle()<cr>", "Split or Join code block with autodetect")

--- inc rename
vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "rename" })


-- surround
keymap("o", "ir", "i[")
keymap("o", "ar", "a[")
keymap("o", "ia", "i<")
keymap("o", "aa", "a<")

-- sniprun
-- keymap({ "n", "v",  }, "<leader>Rr", "<Plug>SnipRun", "sniprun")
keymap({ "n" }, "<leader>R", "<cmd>lua require('sniprun').run('n')<cr>", "sniprun operator")

return pluginKeys
