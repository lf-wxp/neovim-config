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

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  -- Specify snippet engine luasnip
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
    completion = {
      border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
      winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
      winblend = 20,
      scrolloff = 0,
      col_offset = 0,
      side_padding = 1,
      scrollbar = true,
    },
  },
  -- Keymaps
  -- mapping = mapping,
  mapping = {
    -- Show completion
    -- <C-i> might have bug in insert mode with tab, so changed keymap
    ["<A-i>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    -- Cancel
    ["<C-o>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Previous item
    -- ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<Up>"] = cmp.mapping.select_prev_item(),
    -- Next item
    -- ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    -- Confirm
    ["<cr>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    -- Scroll docs if content is too long
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

    -- Super Tab
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    -- end of super Tab
  },
  -- Sources
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
      name = "yanky",
      group_index = 1,
    },
    {
      name = "treesitter",
      group_index = 2,
    },
    {
      name = "buffer",
      group_index = 2,
    },
    {
      name = "async_path",
      group_index = 2,
    },
    {
      name = "calc",
      group_index = 3,
    },
    {
      name = "emoji",
      group_index = 3,
    },
    {
      name = "nvim_lua",
      group_index = 3,
    },
    {
      name = "dictionary",
      keyword_length = 4,
      group_index = 3,
    },
  }),
  -- Use lspkind-nvim to show type icons
  formatting = require("cmp.lspkind").formatting,
})

-- Use buffer source for '/'.
cmp.setup.cmdline("/", {
  mapping = {
    ['<cr>'] = cmp.mapping.confirm({ select = true }),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp_document_symbol" },
    { name = "buffer" },
    { name = "rg",                      keyword_length = 3 },
  }),
})
-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
  mapping = {
    ['<cr>'] = cmp.mapping.confirm({ select = true }),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
  },
  sources = cmp.config.sources({
    { name = "path" },
    { name = "cmdline" },
  }, {
    { name = "cmdline_history" },
  }),
})

cmp.setup.filetype({ "markdown", "help" }, {
  sources = {
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "emoji" },
  },
})

-- npm completions for package.json
require("cmp-npm").setup({
  ignore = {},
  only = {},
  only_semantic_versions = true,
  only_latest_version = false,
})

cmp.setup.filetype("json", {
  sources = cmp.config.sources({
    { name = "npm",      keyword_length = 4, group_index = 1 },
    { name = "nvim_lsp", group_index = 1 },
    { name = "luasnip",  group_index = 1 },
  }, {
    { name = "buffer",     group_index = 2 },
    { name = "async_path", group_index = 2 },
  }),
})

-- git completions
-- stylua: ignore start
local kind_icons = {
  Namespace = "󰌗",
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰆧",
  Constructor = "󰒓",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "󰕘",
  Module = "󰏓",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "󰕘",
  Keyword = "󰌋",
  Snippet = "󰒕",
  Color = "󰏘",
  File = "󰈚",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "󰕘",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "󰉒",
  Operator = "󰆕",
  TypeParameter = "󰊄",
  Table = "󰓫",
  Object = "󰕰",
  Tag = "󰓹",
  Array = "󰅪",
  Boolean = "󰨈",
  Number = "󰎠",
  Null = "󰟢",
  String = "󰉿",
  Calendar = "󰃭",
  Watch = "󰥔",
  Package = "󰆦",
  Copilot = "󰚩",
  Codeium = "󰘦",
  TabNine = "󰚩",
}
-- stylua: ignore end

require("cmp_git").setup({
  filetypes = { "gitcommit", "NeogitCommitMessage" },
  remotes = { "upstream", "origin" },
  enableRemoteUrlRewrites = false,
  formatting = {
    format = function(entry, item)
      if kind_icons[item.kind] then
        item.kind = kind_icons[item.kind] .. " " .. item.kind
      end
      return item
    end,
  },
  github = {
    issues = {
      filter = "all",          -- open, closed, all
      limit = 100,
      state = "open",          -- open, closed, all
      sort_by = "updated_at",  -- created_at, updated_at
      sort_direction = "desc", -- desc, asc
    },
    mentions = {
      limit = 100,
      sort_by = nil,
      sort_direction = nil,
    },
  },
  gitlab = {
    issues = {
      limit = 100,
      state = "opened",        -- opened, closed, all
      sort_by = "updated_at",  -- created_at, updated_at
      sort_direction = "desc", -- desc, asc
    },
    mentions = {
      limit = 100,
      sort_by = nil,
      sort_direction = nil,
    },
  },
  trigger_actions = {
    {
      debug_name = "git_commits",
      trigger_character = ":",
      action = function(sources, trigger_char, callback, params, git_info)
        return sources.git:get_commits(callback, params, trigger_char)
      end,
    },
    {
      debug_name = "github_issues_and_users",
      trigger_character = "#",
      action = function(sources, trigger_char, callback, params, git_info)
        return sources.github:get_issues_and_users(callback, git_info, trigger_char)
      end,
    },
    {
      debug_name = "github_mentions",
      trigger_character = "@",
      action = function(sources, trigger_char, callback, params, git_info)
        return sources.github:get_mentions(callback, git_info, trigger_char)
      end,
    },
  },
})

-- HTML/CSS class completions
-- https://github.com/Jezda1337/nvim-html-css
require("html-css").setup({
  -- Enable on specific file types
  enable_on = {
    "html",
    "htmldjango",
    "tsx",
    "jsx",
    "erb",
    "svelte",
    "vue",
    "blade",
    "php",
    "templ",
    "astro",
  },
  -- Documentation settings
  documentation = {
    auto_show = true,
  },
  -- Style sheets to scan for classes
  -- Leave empty to automatically find CSS files in the project
  style_sheets = {},
  -- Optional: Specify file patterns to ignore
  -- ignore_files = {
  --   "node_modules/**",
  --   ".next/**",
  --   "dist/**",
  -- },
  -- Optional: Enable Tailwind CSS support (requires @tailwindcss/language-server)
  -- enable_tailwindcss = true,
})

cmp.setup.filetype({ "html", "htmldjango", "typescriptreact", "javascriptreact" }, {
  sources = cmp.config.sources({
    { name = "html-css", group_index = 1 },
    { name = "nvim_lsp", group_index = 1 },
    { name = "luasnip",  group_index = 1 },
  }, {
    { name = "treesitter", group_index = 2 },
    { name = "buffer",     group_index = 2 },
    { name = "async_path", group_index = 2 },
  }, {
    { name = "calc",  group_index = 3 },
    { name = "emoji", group_index = 3 },
  }),
})

require("cmp.luasnip")
require("cmp.lspsaga")
