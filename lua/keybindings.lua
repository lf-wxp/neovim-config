vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }

-- 插件快捷键
local pluginKeys = {}

-- 取消 s 默认功能
-- windows 分屏快捷键
map("n", "<leader>sv", ":vsp<CR>", opt)
map("n", "<leader>sh", ":sp<CR>", opt)
-- 关闭当前
map("n", "<leader>sc", "<C-w>c", opt)
-- 关闭其他
map("n", "<leader>so", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<leader>wh", "<C-w>h", opt)
map("n", "<leader>wj", "<C-w>j", opt)
map("n", "<leader>wk", "<C-w>k", opt)
map("n", "<leader>wl", "<C-w>l", opt)

-- 左右比例控制
map("n", "<leader>shh", ":vertical resize -10<CR>", opt)
map("n", "<leader>sll", ":vertical resize +10<CR>", opt)
-- 上下比例
map("n", "<leader>sjj", ":resize +10<CR>", opt)
map("n", "<leader>skk", ":resize -10<CR>", opt)
-- 等比例
map("n", "<leader>s=", "<C-w>=", opt)

-- visual模式下缩进代码
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 上下滚动浏览
pluginKeys.neoscroll = {
  scroll_up = "<leader>u",
  scroll_down = "<leader>d",
}

-- nvim-tree
map("n", "<leader>tt", ":NvimTreeToggle<CR>", opt)

-- bufferline
-- 左右Tab切换
map("n", "<leader>h", ":BufferLineCyclePrev<CR>", opt)
map("n", "<leader>l", ":BufferLineCycleNext<CR>", opt)
map("n", "<leader><", ":BufferLineMovePrev<CR>", opt)
map("n", "<leader>>", ":BufferLineMoveNext<CR>", opt)
map("n", "<leader>tp", ":BufferLinePick<CR>", opt)
-- 关闭
--"moll/vim-bbye"
map("n", "<leader>tc", ":Bdelete!<CR>", opt)
map("n", "<leader>bcl", ":BufferLineCloseRight<CR>", opt)
map("n", "<leader>bch", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)

-- Telescope
-- 查找文件
map("n", "<leader><leader>f", ":Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<leader><leader>t", ":Telescope live_grep<CR>", opt)
-- 全局session
map("n", "<leader><leader>s", ":Autosession session<CR>", opt)
-- 全局project
map("n", "<leader><leader>p", ":Telescope projects<CR>", opt)

-- lsp 捷键设置
pluginKeys.lsp = {
  -- rename
  rename = "<leader>rn",
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


-- spectre
-- 全项目替换
map("n", "<leader>rp", "<cmd>lua require('spectre').open()<CR>", opt)
-- 只替换当前文件
map("n", "<leader>rf", "viw:lua require('spectre').open_file_search()<CR>", opt)
-- 全项目中搜索当前单词
map("n", "<leader>rw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", opt)


-- luasnip
pluginKeys.snip = {
  expand_jumpable = "<C-l>",
  jumpable = "<C-h>",
  choice_active_down = "<C-j>",
  choice_active_up = "<C-k>",
}

-- typescript 快捷键
pluginKeys.ts = {
  organize_import = "<leader>to",
  rename_file = "<leader>tr",
  add_missing_import = "<leader>ti",
  remove_unused = "<leader>tu",
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
  -- 特殊lazygit 窗口，需要安装lazygit
  -- <leader>tg lazygit
  lazygit = "<leader>tg",

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

-- hop
map("n", "<leader>Ml", ":HopLineMW<CR>", opt)
map("n", "<leader>Mw", ":HopWordMW<CR>", opt)
map("n", "<leader>Mf", ":HopChar1MW<CR>", opt)
map("n", "<leader>Mv", ":HopChar2MW<CR>", opt)

map("n", "<leader>ml", ":HopLineAC<CR>", opt)
map("n", "<leader>mL", ":HopLineBC<CR>", opt)
map("n", "<leader>mw", ":HopWordAC<CR>", opt)
map("n", "<leader>mW", ":HopWordBC<CR>", opt)
map("n", "<leader>f", ":HopChar1AC<CR>", opt)
map("n", "<leader>F", ":HopChar1BC<CR>", opt)
map("n", "<leader>v", ":HopChar2AC<CR>", opt)
map("n", "<leader>V", ":HopChar2BC<CR>", opt)

-- Paste from clipboard
map("n", "<leader>p", '"+p', opt)
-- Copy to clipboard
map("n", "<leader>y", '"+y', opt)


-- goto-preview
map("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opt)
map("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", opt)
map("n", "gpc", "<cmd>lua require('goto-preview').close_all_win()<CR>", opt)
map("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", opt)

-- harpoon
map("n", "<leader>na", "<cmd>lua require('harpoon.mark').add_file()<CR>", opt)
map("n", "<leader>nt", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opt)
map("n", "<leader>nn", "<cmd>lua require('harpoon.ui').nav_next()<CR>", opt)
map("n", "<leader>np", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", opt)
map("n", "<leader>n1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", opt)
map("n", "<leader>n2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", opt)
map("n", "<leader>n3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", opt)
map("n", "<leader>n4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", opt)
map("n", "<leader>n5", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", opt)
map("n", "<leader>n6", "<cmd>lua require('harpoon.ui').nav_file(6)<CR>", opt)

-- crates
map("n", "<leader>ct", "<cmd>lua require('crates').toggle()<CR>", opt)
map("n", "<leader>cr", "<cmd>lua require('crates').reload()<CR>", opt)
map("n", "<leader>cv", "<cmd>lua require('crates').show_versions_popup()<CR>", opt)
map("n", "<leader>cf", "<cmd>lua require('crates').show_features_popup()<CR>", opt)
map("n", "<leader>cd", "<cmd>lua require('crates').show_dependencies_popup()<CR>", opt)
map("n", "<leader>cu", "<cmd>lua require('crates').update_crate()<CR>", opt)
map("n", "<leader>cu", "<cmd>lua require('crates').update_crates()<CR>", opt)
map("n", "<leader>cU", "<cmd>lua require('crates').upgrade_crate()<CR>", opt)
map("n", "<leader>cU", "<cmd>lua require('crates').upgrade_crates()<CR>", opt)
map("n", "<leader>cA", "<cmd>lua require('crates').upgrade_all_crates()<CR>", opt)
map("n", "<leader>cH", "<cmd>lua require('crates').open_homepage()<CR>", opt)
map("n", "<leader>cR", "<cmd>lua require('crates').open_repository()<CR>", opt)
map("n", "<leader>cD", "<cmd>lua require('crates').open_documentation()<CR>", opt)
map("n", "<leader>cC", "<cmd>lua require('crates').open_crates_io()<CR>", opt)

--hlslens
map("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], opt)
map("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], opt)
map("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], opt)
map("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], opt)
map("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], opt)
map("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], opt)
map("n", "<leader>k", ":noh<CR>", opt)


map("n", "<leader>o", "<C-o>", opt)
map("n", "<leader>i", "<C-i>", opt)

return pluginKeys
