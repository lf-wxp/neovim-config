vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }

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

-- Terminal相关
-- map("n", "<leader>t", ":sp | terminal<CR>", opt)
-- map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
-- map("t", "<Esc>", "<C-\\><C-n>", opt)
-- map("t", "<C-h>", [[ <C-\><C-N><C-w>h ]], opt)
-- map("t", "<C-j>", [[ <C-\><C-N><C-w>j ]], opt)
-- map("t", "<C-k>", [[ <C-\><C-N><C-w>k ]], opt)
-- map("t", "<C-l>", [[ <C-\><C-N><C-w>l ]], opt)

-- visual模式下缩进代码
-- map("v", "<", "<gv", opt)
-- map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 上下滚动浏览
-- map("n", "<C-j>", "4j", opt)
-- map("n", "<C-k>", "4k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
-- map("n", "<leader>u", "<C-u>", opt)
-- map("n", "<leader>d", "<C-d>", opt)

-- 插件快捷键
local pluginKeys = {}

-- nvim-tree
map("n", "<leader>tt", ":NvimTreeToggle<CR>", opt)
-- 列表快捷键
pluginKeys.nvimTreeList = {
  -- 打开文件或文件夹
  { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
  -- 分屏打开文件
  { key = "v", action = "vsplit" },
  { key = "h", action = "split" },
  -- 显示隐藏文件
  { key = "i", action = "toggle_custom" }, -- 对应 filters 中的 custom (node_modules)
  { key = ".", action = "toggle_dotfiles" }, -- Hide (dotfiles)
  -- 文件操作
  { key = "<F5>", action = "refresh" },
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "r", action = "rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "s", action = "system_open" },
}

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
map("n", "<leader><leader>s", ":Telescope session-lens search_session<CR>", opt)
-- 全局project
map("n", "<leader><leader>p", ":Telescope projects<CR>", opt)
-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ["<Down>"] = "move_selection_next",
    ["<Up>"] = "move_selection_previous",
    -- 历史记录
    ["<C-n>"] = "cycle_history_next",
    ["<C-p>"] = "cycle_history_prev",
    -- 关闭窗口
    ["<C-c>"] = "close",
    -- 预览窗口上下滚动
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",

    -- either hot-reloaded or `function(prompt_bufnr) telescope.extensions.hop.hop end`
    ["<leader>h"] = require("telescope").extensions.hop.hop,  -- hop.hop_toggle_selection
    -- custom hop loop to multi selects and sending selected entries to quickfix list 
    ["<C-space>"] = function(prompt_bufnr)
      local opts = {
        callback = actions.toggle_selection,
        loop_callback = actions.send_selected_to_qflist,
      }
      require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
    end,
  },
}

-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(mapbuf)
  -- rename
  -- mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
  mapbuf("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opt)
  -- code action
  -- mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
  mapbuf("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opt)
  -- go xx
  mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)

  -- mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
  mapbuf("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opt)
  -- scroll down hover doc or scroll in definition preview
  mapbuf("n", "su", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>", opt)
 -- scroll up hover doc
  mapbuf("n", "sd", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", opt)

  mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
  mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)

  -- mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
  mapbuf("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opt)
  -- diagnostic
  mapbuf("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
  mapbuf("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opt)
  mapbuf("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opt)
  mapbuf("n", "==", "<cmd>lua vim.lsp.buf.format()<CR>", opt)
  -- mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
  -- mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
  -- mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
  -- mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
  -- 没用到
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end


-- spectre
-- 全项目替换
map("n", "<leader>rp", "<cmd>lua require('spectre').open()<CR>", opt)
-- 只替换当前文件
map("n", "<leader>rf", "viw:lua require('spectre').open_file_search()<CR>", opt)
-- 全项目中搜索当前单词
map("n", "<leader>rw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", opt)

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  return {
    -- 出现补全
    -- 可能是<C-i> 有bug导致在i模式tab使用有问题,所以换了快捷键 
    ["<A-i>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    -- 取消
    ["<C-o>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    
    -- 上一个
    -- ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<Up>"] = cmp.mapping.select_prev_item(),
    -- 下一个
    -- ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    -- 确认
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    -- 如果窗口内容太多，可以滚动
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

    -- 自定义代码段跳转到下一个参数
    ["<C-l>"] = cmp.mapping(function(_)
      if vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      end
    end, { "i", "s" }),

    -- 自定义代码段跳转到上一个参数
    ["<C-h>"] = cmp.mapping(function()
      if vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),

    -- Super Tab
    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif vim.fn["vsnip#available"](1) == 1 then
    --     feedkey("<Plug>(vsnip-expand-or-jump)", "")
    --   elseif has_words_before() then
    --     cmp.complete()
    --   else
    --     fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
    --   end
    -- end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
    -- end of super Tab
  }
end

-- typescript 快捷键
pluginKeys.mapTsLSP = function(mapbuf)
  mapbuf("n", "<leader>to", ":TSLspOrganize<CR>", opt)
  mapbuf("n", "<leader>tr", ":TSLspRenameFile<CR>", opt)
  mapbuf("n", "<leader>ti", ":TSLspImportAll<CR>", opt)
end

-- 代码注释插件
-- see ./lua/plugin-config/comment.lua
pluginKeys.comment = {
  -- Normal 模式快捷键
  toggler = {
    line = "gcc", -- 行注释
    block = "gbc", -- 块注释
  },
  -- Visual 模式
  opleader = {
    line = "gc",
    bock = "gb",
  },
}

-- 自定义 toggleterm 3个不同类型的命令行窗口
-- <leader>tf 浮动
-- <leader>tr 右侧
-- <leader>td 下方
-- 特殊lazygit 窗口，需要安装lazygit
-- <leader>tg lazygit
pluginKeys.mapToggleTerm = function(toggleterm)
  vim.keymap.set({ "n", "t" }, "<leader>tf", toggleterm.toggleA)
  vim.keymap.set({ "n", "t" }, "<leader>tr", toggleterm.toggleB)
  vim.keymap.set({ "n", "t" }, "<leader>td", toggleterm.toggleC)
  vim.keymap.set({ "n", "t" }, "<leader>tg", toggleterm.toggleG)
  map("t", "<Esc>", "<C-\\><C-n>", opt)
end

-- gitsigns
pluginKeys.gitsigns_on_attach = function(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map("n", "<leader>gj", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return "<Ignore>"
  end, { expr = true })

  map("n", "<leader>gk", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, { expr = true })

  map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
  map("n", "<leader>gS", gs.stage_buffer)
  map("n", "<leader>gu", gs.undo_stage_hunk)
  map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
  map("n", "<leader>gR", gs.reset_buffer)
  map("n", "<leader>gp", gs.preview_hunk)
  map("n", "<leader>gb", function()
    gs.blame_line({ full = true })
  end)
  map("n", "<leader>gd", gs.diffthis)
  map("n", "<leader>gD", function()
    gs.diffthis("~")
  end)
  -- toggle
  map("n", "<leader>gtd", gs.toggle_deleted)
  map("n", "<leader>gtb", gs.toggle_current_line_blame)
  -- Text object
  map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
end

-- lazyGit
-- map("n", "<leader>gg", ":LazyGit<CR>", opt)

-- hop
map("n", "f",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
  , {})
map("n", "F",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
  , opt)
map("o", "f",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
  , opt)
map("o", "F",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
  , opt)
map("", "t",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
  , opt)
map("", "T",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
  , opt)
map("n", "<leader>e", "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>",
  opt)
map("v", "<leader>e", "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>",
  opt)
map("o", "<leader>e",
  "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, inclusive_jump = true })<cr>"
  , opt)
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

-- barbar
-- map("n", "<leader>h", ":BufferPrevious<CR>", opt)
-- map("n", "<leader>l", ":BufferNext<CR>", opt)
-- map("n", "<leader><", ":BufferMovePrevious<CR>", opt)
-- map("n", "<leader>>", ":BufferMoveNext<CR>", opt)
-- map("n", "<leader>tp", ":BufferPick<CR>", opt)
-- map("n", "<leader>th", ":BufferScrollLeft 50<CR>", opt)
-- map("n", "<leader>tl", ":BufferScrollRight 50<CR>", opt)
-- -- 关闭
-- map("n", "<leader>tc", ":BufferClose<CR>", opt)

map("n", "<leader>o", "<C-o>", opt)
map("n", "<leader>i", "<C-i>", opt)

return pluginKeys
