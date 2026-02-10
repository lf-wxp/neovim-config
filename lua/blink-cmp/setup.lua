-- ╭────────────────────────────────────────────────────────╮
-- │ blink.cmp - Completion Engine (replaces nvim-cmp)      │
-- │ https://github.com/Saghen/blink.cmp                    │
-- ╰────────────────────────────────────────────────────────╯

local blink = require("blink.cmp")

-- ╭────────────────────────────────────────────────────────╮
-- │ Kind Icons (consistent with lspkind config)            │
-- ╰────────────────────────────────────────────────────────╯
-- stylua: ignore start
local kind_icons = {
  Text          = "󰉿",
  Method        = "󰆧",
  Function      = "󰆧",
  Constructor   = "󰒓",
  Field         = "󰜢",
  Variable      = "󰀫",
  Class         = "󰠱",
  Interface     = "󰕘",
  Module        = "󰏓",
  Property      = "󰜢",
  Unit          = "󰑭",
  Value         = "󰎠",
  Enum          = "󰕘",
  Keyword       = "󰌋",
  Snippet       = "󰒕",
  Color         = "󰏘",
  File          = "󰈚",
  Reference     = "󰈇",
  Folder        = "󰉋",
  EnumMember    = "󰕘",
  Constant      = "󰏿",
  Struct        = "󰙅",
  Event         = "󰉒",
  Operator      = "󰆕",
  TypeParameter = "󰊄",
  Namespace     = "󰌗",
  Table         = "󰓫",
  Object        = "󰕰",
  Tag           = "󰓹",
  Array         = "󰅪",
  Boolean       = "󰨈",
  Number        = "󰎠",
  Null          = "󰟢",
  String        = "󰉿",
  Calendar      = "󰃭",
  Watch         = "󰥔",
  Package       = "󰆦",
  Copilot       = "󰚩",
  Codeium       = "󰘦",
  TabNine       = "󰚩",
}
-- stylua: ignore end

blink.setup({
  -- ╭────────────────────────────────────────────────────────╮
  -- │ Snippet Config (using LuaSnip)                         │
  -- ╰────────────────────────────────────────────────────────╯
  snippets = { preset = "luasnip" },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ Appearance                                             │
  -- ╰────────────────────────────────────────────────────────╯
  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = "mono",
    kind_icons = kind_icons,
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ Completion                                             │
  -- ╰────────────────────────────────────────────────────────╯
  completion = {
    -- Completion menu
    menu = {
      border = "padded",
      winblend = 0,
      winhighlight = "Normal:BlinkCmpMenu,NormalFloat:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
      scrolloff = 2,
      -- 自定义 cmdline 位置：利用 noice API 让补全框出现在 cmdline popup 下方
      cmdline_position = function()
        -- 通过 noice API 获取 cmdline 位置和窗口信息
        local noice_ok, noice_api = pcall(require, "noice.api")
        local cmdline_pos = noice_ok and noice_api.get_cmdline_position() or nil

        if cmdline_pos and cmdline_pos.win and vim.api.nvim_win_is_valid(cmdline_pos.win) then
          local win = cmdline_pos.win
          local conf = vim.api.nvim_win_get_config(win)

          -- nui content window 的屏幕位置和尺寸
          local content_pos = vim.api.nvim_win_get_position(win) -- (0-indexed)
          local content_height = vim.api.nvim_win_get_height(win)
          local content_width = vim.api.nvim_win_get_width(win)

          -- nui 的 content window 是 relative="win"，conf.row/col 即为 padding
          local pad_top = (conf.relative == "win" and type(conf.row) == "number") and conf.row or 0
          local pad_left = (conf.relative == "win" and type(conf.col) == "number") and conf.col or 0

          -- 通过 border window 获取精确的整体尺寸
          local total_width = content_width + pad_left * 2
          local pad_bottom = pad_top
          if conf.relative == "win" and conf.win then
            local b_h_ok, border_height = pcall(vim.api.nvim_win_get_height, conf.win)
            local b_w_ok, border_width = pcall(vim.api.nvim_win_get_width, conf.win)
            if b_h_ok and b_w_ok then
              total_width = border_width
              pad_bottom = border_height - content_height - pad_top
            end
          end

          -- 窗口底部 = content 底部 + bottom padding
          -- local win_bottom = content_pos[1] + content_height + pad_bottom
          local win_bottom = content_pos[1] + content_height
          -- 窗口左边缘 = content 左边 - left padding
          local win_left = content_pos[2] - pad_left

          -- 动态修改 blink.cmp menu 的宽度与 cmdline popup 一致
          vim.g._blink_cmdline_width = total_width
          local menu_ok, menu_mod = pcall(require, "blink.cmp.completion.windows.menu")
          if menu_ok and menu_mod.win then
            local menu_border_size = menu_mod.win:get_border_size()
            local scrollbar_width = 0
            if menu_mod.win.scrollbar and menu_mod.win.scrollbar:is_visible() then
              scrollbar_width = 1
            end
            local target_content_width = total_width - menu_border_size.horizontal - scrollbar_width
            if target_content_width > 0 then
              menu_mod.win.config.min_width = target_content_width
              if menu_mod.win:is_open() then
                vim.api.nvim_win_set_width(menu_mod.win:get_win(), target_content_width)
              end
            end
          end

          -- 预补偿 blink.cmp 内部的 start_col - alignment_start_col 偏移
          local col_offset = 0
          if menu_ok and menu_mod.context and menu_mod.renderer then
            local start_col = menu_mod.context.bounds.start_col or 0
            local align_col_ok, align_col = pcall(function()
              return menu_mod.renderer:get_alignment_start_col()
            end)
            local alignment_start_col = (align_col_ok and align_col) or 0
            col_offset = start_col - alignment_start_col
          end

          return { win_bottom, win_left - col_offset }
        end

        -- 回退：使用 vim.g.ui_cmdline_pos（noice 不可用时）
        if vim.g.ui_cmdline_pos ~= nil then
          local pos = vim.g.ui_cmdline_pos
          return { pos[1] - 1, pos[2] }
        end

        local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
        return { vim.o.lines - height, 0 }
      end,
      draw = {
        -- Padding between columns
        padding = { 1, 1 },
        -- Use treesitter for label highlighting
        treesitter = { "lsp" },
        columns = {
          { "kind_icon", width = 2 },
          { "label", "label_description", gap = 1 },
          { "kind", "source_name", gap = 1 },
        },
        components = {
          kind_icon = {
            text = function(ctx)
              return ctx.kind_icon .. " "
            end,
            -- Dynamically color icon based on CompletionItemKind
            highlight = function(ctx)
              return "BlinkCmpKind" .. ctx.kind
            end,
          },
          kind = {
            text = function(ctx)
              return ctx.kind
            end,
            highlight = function(ctx)
              return "BlinkCmpKind" .. ctx.kind
            end,
          },
          source_name = {
            text = function(ctx)
              return "[" .. ctx.source_name .. "]"
            end,
            highlight = "BlinkCmpSource",
          },
        },
      },
    },
    -- Documentation popup
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = {
        border = "padded",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpDoc,NormalFloat:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
      },
    },
    -- Ghost text
    ghost_text = { enabled = false },
    -- Completion list
    list = {
      selection = {
        preselect = true,
        auto_insert = true,
      },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ Signature Help                                         │
  -- ╰────────────────────────────────────────────────────────╯
  signature = {
    enabled = true,
    window = {
      border = "padded",
      winblend = 0,
      winhighlight = "Normal:BlinkCmpSignatureHelp,NormalFloat:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
      scrollbar = false,
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ Fuzzy Matching                                         │
  -- ╰────────────────────────────────────────────────────────╯
  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ Keymaps                                                │
  -- ╰────────────────────────────────────────────────────────╯
  keymap = {
    preset = "none",
    -- Show completion
    ["<A-i>"] = { "show" },
    -- Cancel
    ["<C-o>"] = { "cancel", "fallback" },
    -- Select prev/next
    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    -- Accept
    ["<CR>"] = { "accept", "fallback" },
    -- Scroll documentation
    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    -- Super Tab
    ["<Tab>"] = {
      function(cmp)
        if cmp.is_visible() then
          return cmp.select_next()
        elseif require("luasnip").expand_or_jumpable() then
          require("luasnip").expand_or_jump()
          return true
        end
      end,
      "fallback",
    },
    ["<S-Tab>"] = {
      function(cmp)
        if cmp.is_visible() then
          return cmp.select_prev()
        elseif require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
          return true
        end
      end,
      "fallback",
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ Cmdline Completion (natively supports noice.nvim)      │
  -- ╰────────────────────────────────────────────────────────╯
  cmdline = {
    enabled = true,
    keymap = {
      preset = "none",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-o>"] = { "cancel", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
    },
    completion = {
      menu = {
        auto_show = true,
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
    },
  },

  -- ╭────────────────────────────────────────────────────────╮
  -- │ Completion Sources                                     │
  -- ╰────────────────────────────────────────────────────────╯
  sources = {
    -- Default sources (priority determined by order)
    default = {
      "lsp",
      "snippets",
      "path",
      "buffer",
      "lazydev",
      "emoji",
      "yanky",
      "treesitter",
      "calc",
      "dictionary",
    },
    -- Provider configurations
    providers = {
      -- Built-in sources
      lsp = {
        name = "LSP",
        module = "blink.cmp.sources.lsp",
        score_offset = 100,
      },
      snippets = {
        name = "Snippets",
        module = "blink.cmp.sources.snippets",
        score_offset = 90,
      },
      path = {
        name = "Path",
        module = "blink.cmp.sources.path",
        score_offset = 80,
      },
      buffer = {
        name = "Buffer",
        module = "blink.cmp.sources.buffer",
        score_offset = 50,
      },
      -- lazydev (native blink.cmp support)
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
      -- Native blink community sources
      emoji = {
        name = "Emoji",
        module = "blink-emoji",
        score_offset = 30,
      },
      -- nvim-cmp sources bridged via blink.compat
      yanky = {
        name = "Yanky",
        module = "blink.compat.source",
        score_offset = 60,
        opts = { cmp_source = { name = "yanky" } },
      },
      treesitter = {
        name = "Treesitter",
        module = "blink.compat.source",
        score_offset = 50,
        opts = { cmp_source = { name = "treesitter" } },
      },
      calc = {
        name = "Calc",
        module = "blink.compat.source",
        score_offset = 30,
        opts = { cmp_source = { name = "calc" } },
      },
      dictionary = {
        name = "Dict",
        module = "blink.compat.source",
        score_offset = 20,
        min_keyword_length = 4,
        opts = { cmp_source = { name = "dictionary" } },
      },
      -- npm completion (JSON files only)
      npm = {
        name = "NPM",
        module = "blink.compat.source",
        score_offset = 80,
        opts = { cmp_source = { name = "npm" } },
      },
      -- HTML/CSS completion
      ["html-css"] = {
        name = "HTML-CSS",
        module = "blink.compat.source",
        score_offset = 80,
        opts = { cmp_source = { name = "html-css" } },
      },
      -- Git completion
      git = {
        name = "Git",
        module = "blink-cmp-git",
        score_offset = 80,
        opts = {
          remotes = { "upstream", "origin" },
        },
      },
      -- Search-related sources
      rg = {
        name = "RG",
        module = "blink.compat.source",
        score_offset = 40,
        opts = { cmp_source = { name = "rg", keyword_length = 3 } },
      },
      document_symbol = {
        name = "DocSymbol",
        module = "blink.compat.source",
        score_offset = 60,
        opts = { cmp_source = { name = "nvim_lsp_document_symbol" } },
      },
      cmdline_history = {
        name = "History",
        module = "blink.compat.source",
        score_offset = 30,
        opts = { cmp_source = { name = "cmdline_history" } },
      },
    },

    -- Per-filetype source overrides
    per_filetype = {
      -- Markdown / Help files
      markdown = { "snippets", "buffer", "path", "emoji" },
      help = { "snippets", "buffer", "path", "emoji" },
      -- JSON files (npm completion)
      json = { "npm", "lsp", "snippets", "buffer", "path" },
      -- Git commit messages
      gitcommit = { "git", "snippets", "buffer", "path", "emoji" },
      NeogitCommitMessage = { "git", "snippets", "buffer", "path", "emoji" },
      -- HTML/Frontend files
      html = { "html-css", "lsp", "snippets", "treesitter", "buffer", "path", "calc", "emoji" },
      htmldjango = { "html-css", "lsp", "snippets", "treesitter", "buffer", "path", "calc", "emoji" },
      typescriptreact = { "html-css", "lsp", "snippets", "treesitter", "buffer", "path", "calc", "emoji" },
      javascriptreact = { "html-css", "lsp", "snippets", "treesitter", "buffer", "path", "calc", "emoji" },
    },
  },
})

-- ╭────────────────────────────────────────────────────────╮
-- │ cmp-npm Initialization                                 │
-- ╰────────────────────────────────────────────────────────╯
local npm_ok, cmp_npm = pcall(require, "cmp-npm")
if npm_ok then
  cmp_npm.setup({
    ignore = {},
    only = {},
    only_semantic_versions = true,
    only_latest_version = false,
  })
end

-- ╭────────────────────────────────────────────────────────╮
-- │ nvim-html-css Initialization                           │
-- ╰────────────────────────────────────────────────────────╯
local html_ok, html_css = pcall(require, "html-css")
if html_ok then
  html_css.setup({
    enable_on = {
      "html", "htmldjango", "tsx", "jsx",
      "erb", "svelte", "vue", "blade",
      "php", "templ", "astro",
    },
    documentation = { auto_show = true },
    style_sheets = {},
  })
end

-- ╭────────────────────────────────────────────────────────╮
-- │ Cmdline 补全框宽度对齐 noice cmdline popup             │
-- ╰────────────────────────────────────────────────────────╯
-- 补全菜单位置更新后，确保宽度与 cmdline popup 一致（双重保障）
vim.api.nvim_create_autocmd("User", {
  pattern = { "BlinkCmpMenuOpen", "BlinkCmpMenuPositionUpdate" },
  callback = function()
    if vim.api.nvim_get_mode().mode ~= "c" then
      return
    end

    local cmdline_width = vim.g._blink_cmdline_width
    if not cmdline_width then
      return
    end

    local menu_ok, menu = pcall(require, "blink.cmp.completion.windows.menu")
    if not menu_ok or not menu.win or not menu.win:is_open() then
      return
    end

    local border_size = menu.win:get_border_size()
    -- 滚动条在 padded border 下额外占 1 列宽度
    local scrollbar_width = 0
    if menu.win.scrollbar and menu.win.scrollbar:is_visible() then
      scrollbar_width = 1
    end
    local target_width = cmdline_width - border_size.horizontal - scrollbar_width
    if target_width > 0 then
      vim.api.nvim_win_set_width(menu.win:get_win(), target_width)
    end
  end,
})

-- 退出 cmdline 模式时恢复默认 min_width
vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function()
    vim.g._blink_cmdline_width = nil
    local menu_ok, menu = pcall(require, "blink.cmp.completion.windows.menu")
    if menu_ok and menu.win then
      menu.win.config.min_width = 15 -- blink.cmp 默认值
    end
  end,
})
