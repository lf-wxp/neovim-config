-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/onsails/lspkind-nvim
local status, cmp = pcall(require, "cmp")
if not status then
  return
end

local status, luasnip = pcall(require, "luasnip")
if not status then
  return
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  -- 指定 snippet 引擎 luasnip
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  -- 快捷键
  -- mapping = mapping,
  mapping = {
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
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
    -- end of super Tab
  },
  -- 来源
  sources = cmp.config.sources({
    {
      name = "luasnip",
      group_index = 1,
    },
    {
      name = "nvim_lsp",
      group_index = 1,
    },
    {
      name = "nvim_lsp_signature_help",
      group_index = 1,
    },
    {
      name = "buffer",
      group_index = 2,
    },
    {
      name = "path",
      group_index = 2,
    },
  }),
  -- 使用lspkind-nvim显示类型图标
  formatting = require("cmp.lspkind").formatting,
})

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
  },
  sources = { {
    name = "buffer",
  } },
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
  },
  sources = cmp.config.sources({ {
    name = "path",
  } }, { {
    name = "cmdline",
  } }),
})

cmp.setup.filetype({ "markdown", "help" }, {
  sources = { {
    name = "luasnip",
  }, {
    name = "buffer",
  }, {
    name = "path",
  } },
})

require("cmp.luasnip")
require("cmp.lspsaga")
