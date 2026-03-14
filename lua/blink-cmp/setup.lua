-- ╭────────────────────────────────────────────────────────╮
-- │ blink.cmp - Completion Engine (replaces nvim-cmp)      │
-- │ https://github.com/Saghen/blink.cmp                    │
-- ╰────────────────────────────────────────────────────────╯

local blink = require("blink.cmp")

-- ╭────────────────────────────────────────────────────────╮
-- │ colorful-menu.nvim - Semantic Highlighted Labels       │
-- ╰────────────────────────────────────────────────────────╯
require("colorful-menu").setup({
  ls = {
    -- Enable semantic highlighting for all LSP servers
    ["lua_ls"] = {
      arguments_hl = "@comment",
    },
    ["ts_ls"] = {
      extra_info_hl = "@comment",
    },
    ["vtsls"] = {
      extra_info_hl = "@comment",
    },
    -- Default config for all LSP servers without specific overrides
    ["_"] = {
      arguments_hl = "@comment",
      extra_info_hl = "@comment",
    },
  },
  fallback_highlight = "@variable",
  max_width = 60,
})

-- ╭────────────────────────────────────────────────────────╮
-- │ Kind Icons (shared definition from config/icons.lua)   │
-- ╰────────────────────────────────────────────────────────╯
local kind_icons = require("config.icons").kind_icons

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
      winhighlight =
      "Normal:BlinkCmpMenu,NormalFloat:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
      scrolloff = 2,
      -- Custom cmdline position: use noice API to place completion menu below cmdline popup
      cmdline_position = function()
        -- Get cmdline position and window info via noice API
        local noice_ok, noice_api = pcall(require, "noice.api")
        local cmdline_pos = noice_ok and noice_api.get_cmdline_position() or nil

        if cmdline_pos and cmdline_pos.win and vim.api.nvim_win_is_valid(cmdline_pos.win) then
          local win = cmdline_pos.win
          local conf = vim.api.nvim_win_get_config(win)

          -- nui content window screen position and dimensions
          local content_pos = vim.api.nvim_win_get_position(win) -- (0-indexed)
          local content_height = vim.api.nvim_win_get_height(win)
          local content_width = vim.api.nvim_win_get_width(win)

          -- nui content window uses relative="win", conf.row/col represent padding
          local pad_top = (conf.relative == "win" and type(conf.row) == "number") and conf.row or 0
          local pad_left = (conf.relative == "win" and type(conf.col) == "number") and conf.col or 0

          -- Get precise overall dimensions via border window
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

          -- Window bottom = content bottom + bottom padding
          -- local win_bottom = content_pos[1] + content_height + pad_bottom
          local win_bottom = content_pos[1] + content_height
          -- Window left edge = content left - left padding
          local win_left = content_pos[2] - pad_left

          -- Dynamically adjust blink.cmp menu width to match cmdline popup
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

          -- Pre-compensate for blink.cmp internal start_col - alignment_start_col offset
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

        -- Fallback: use vim.g.ui_cmdline_pos (when noice is unavailable)
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
        -- colorful-menu.nvim handles label semantic highlighting, treesitter not needed
        -- treesitter = { "lsp" },
        columns = {
          { "kind_icon" },
          -- colorful-menu merges label_description into label, no need to list separately
          { "label",    gap = 1 },
          { "kind",     "source_name", gap = 1 },
        },
        components = {
          kind_icon = {
            text = function(ctx)
              -- default kind icon
              local icon = ctx.kind_icon
              -- if LSP source, check for color derived from documentation
              if ctx.item.source_name == "LSP" then
                local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                if color_item and color_item.abbr ~= "" then
                  icon = color_item.abbr
                end
              end
              return icon .. ctx.icon_gap
            end,
            highlight = function(ctx)
              -- default highlight group
              local highlight = "BlinkCmpKind" .. ctx.kind
              -- if LSP source, check for color derived from documentation
              if ctx.item.source_name == "LSP" then
                local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                if color_item and color_item.abbr_hl_group then
                  highlight = color_item.abbr_hl_group
                end
              end
              return highlight
            end,
          },
          label = {
            width = { fill = true, max = 60 },
            text = function(ctx)
              return require("colorful-menu").blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require("colorful-menu").blink_components_highlight(ctx)
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
      winhighlight =
      "Normal:BlinkCmpSignatureHelp,NormalFloat:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
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
      vue = { "html-css", "lsp", "snippets", "treesitter", "buffer", "path", "calc", "emoji" },
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
-- │ Cmdline Menu Width Alignment with Noice Popup         │
-- ╰────────────────────────────────────────────────────────╯
-- After menu position update, ensure width matches cmdline popup (double guarantee)
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
    -- Scrollbar takes an extra column width under padded border
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

-- Reset min_width to default when leaving cmdline mode
vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function()
    vim.g._blink_cmdline_width = nil
    local menu_ok, menu = pcall(require, "blink.cmp.completion.windows.menu")
    if menu_ok and menu.win then
      menu.win.config.min_width = 15 -- blink.cmp default
    end
  end,
})
