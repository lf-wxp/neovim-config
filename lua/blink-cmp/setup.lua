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
      draw = {
        -- Padding between columns
        padding = { 1, 1 },
        -- Use treesitter for label highlighting
        treesitter = { "lsp" },
        columns = {
          { "kind_icon" },
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
