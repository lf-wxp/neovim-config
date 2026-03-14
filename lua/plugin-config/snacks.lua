-- ╭────────────────────────────────────────────────────────╮
-- │          snacks.nvim - Multi-purpose Plugin Config     │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.opts = {
  scroll = {
    enabled = true,
    animate = {
      duration = { step = 10, total = 150 },
      easing = "linear",
    },
    animate_repeat = {
      delay = 100,
      duration = { step = 5, total = 50 },
      easing = "linear",
    },
  },
  input = { enabled = true },     -- Input enhancement
  bigfile = { enabled = true },   -- Big file optimization
  quickfile = { enabled = true }, -- Quick file open
  words = { enabled = true },     -- Highlight current word
  styles = {
    notification = {
      border = "solid",
      wo = {
        winblend = 10,
      },
    },
    notification_history = {
      border = "solid",
      wo = {
        winblend = 10,
      },
    },
    terminal = {
      wo = {
        winblend = 10,
        winbar = " Terminal"
      },
      border = "solid",
    }
  },
  terminal = {
    enabled = true,
  },
  toggle = {
    enabled = true,
    map = vim.keymap.set, -- keymap.set function to use
    which_key = true,   -- integrate with which-key to show enabled/disabled icons and colors
    notify = true,      -- show a notification when toggling
    -- icons for enabled/disabled states
    icon = {
      enabled = " ",
      disabled = " ",
    },
    -- colors for enabled/disabled states
    color = {
      enabled = "green",
      disabled = "yellow",
    },
    wk_desc = {
      enabled = "Disable",
      disabled = "Enable",
    },
  },
  notifier = {
    enabled = true,
    -- Timeout for notifications (ms)
    timeout = 3000,
    -- Maximum number of notifications to show at once
    max_width = 60,
    -- Padding inside notification window
    padding = true,
    -- Sort notifications ("added" | "level")
    sort = { "level", "added" },
    -- Minimum notification level to show
    level = vim.log.levels.TRACE,
    -- Icons for different notification levels
    icons = {
      error = "󰅚 ",
      warn = " ",
      info = " ",
      debug = " ",
      trace = "󰑐 ",
    },
    -- Style: "compact" | "fancy" | "minimal"
    style = "fancy",
    -- Top-down or bottom-up
    top_down = true,
    -- Animation style
    animate = {
      -- Animation enabled
      enabled = true,
      -- Animation duration (ms)
      duration = 300,
      -- Animation easing function
      easing = "linear",
      -- Animation fps (30 is smooth enough for notifications)
      fps = 30,
    },
    -- Notification window appearance
    -- Keep notification on screen
    keep = function(notif)
      return notif.level == vim.log.levels.ERROR
    end,
  },
  statuscolumn = { enabled = true }, -- Line number column enhancement (fold marks, git status, etc.)
  indent = {
    enabled = true,
    -- Char for indent line
    char = "│",
    -- Rainbow mode: automatically cycle colors for each indent level
    rainbow = {
      enabled = true,
      -- Highlight groups for rainbow colors
      hl = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      },
    },
    -- Faster animation
    animate = {
      enabled = true,
      style = "out",
      easing = "linear",
      duration = {
        step = 10,   -- Faster animation step (ms)
        total = 150, -- Faster total animation time (ms)
      },
    },
    -- Scope highlight (current indent level)
    scope = {
      enabled = true,
      char = "│",
      underline = false,
      only_current = false,
      hl = "SnacksIndentScope",
    },
    -- Chunk: highlight current code block (function, if, for, etc.)
    chunk = {
      enabled = true,
      -- Characters for chunk borders
      chars = {
        corner_top = "┌",
        corner_bottom = "└",
        horizontal = "─",
        vertical = "│",
        arrow = "─",
      },
      -- Style: "full" | "minimal"
      style = "full",
      -- Highlight group for chunk
      hl = "SnacksIndentChunk",
    },
    -- Filter function to disable for some filetypes/buftypes
    filter = function(buf)
      return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
    end,
  },
  -- Replace dashboard-nvim
  dashboard = {
    enabled = true,
    preset = {
      keys = {
        { icon = "󰈞 ", key = "f", desc = "Find File", action = ":Telescope find_files" },
        { icon = "󰝒 ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = "󰍉 ", key = "t", desc = "Find Text", action = ":Telescope live_grep_args" },
        { icon = "󰋚 ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
        { icon = "󰏓 ", key = "p", desc = "Projects", action = ":Telescope projects" },
        { icon = "󰋚 ", key = "s", desc = "Restore Session", action = ":SessionRestore" },
        { icon = "󰉖 ", key = "o", desc = "Oil Browser", action = ":Oil" },
        { icon = "󰊢 ", key = "g", desc = "Git Status", action = ":Neogit" },
        { icon = "󰋗 ", key = "h", desc = "Help Tags", action = ":Telescope help_tags" },
        { icon = "󰌌 ", key = "k", desc = "Keybindings", action = ":edit ~/.config/nvim/lua/config/keymaps.lua" },
        { icon = "󰒲 ", key = "u", desc = "Update", action = ":Lazy sync" },
        { icon = "󰅚 ", key = "q", desc = "Quit", action = ":qa" },
      },
      header = [[
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⣠⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣡⣾⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣟⠻⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⡿⢫⣷⣿⣿⣿⣿⣿⣿⣿⣾⣯⣿⡿⢧⡚⢷⣌⣽⣿⣿⣿⣿⣿⣶⡌⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⠇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣇⣘⠿⢹⣿⣿⣿⣿⣿⣻⢿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⣿⡟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣻⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⡇⠀⣬⠏⣿⡇⢻⣿⣿⣿⣿⣿⣿⣿⣷⣼⣿⣿⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⠀⠈⠁⠀⣿⡇⠘⡟⣿⣿⣿⣿⣿⣿⣿⣿⡏⠿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣇⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⡏⠀⠀⠐⠀⢻⣇⠀⠀⠹⣿⣿⣿⣿⣿⣿⣩⡶⠼⠟⠻⠞⣿⡈⠻⣟⢻⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢿⠀⡆⠀⠘⢿⢻⡿⣿⣧⣷⢣⣶⡃⢀⣾⡆⡋⣧⠙⢿⣿⣿⣟⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⡥⠂⡐⠀⠁⠑⣾⣿⣿⣾⣿⣿⣿⡿⣷⣷⣿⣧⣾⣿⣿⣿⣿⣿⣿⣿
⣿⣿⡿⣿⣍⡴⠆⠀⠀⠀⠀⠀⠀⠀⠀⣼⣄⣀⣷⡄⣙⢿⣿⣿⣿⣿⣯⣶⣿⣿⢟⣾⣿⣿⢡⣿⣿⣿⣿⣿
⣿⡏⣾⣿⣿⣿⣷⣦⠀⠀⠀⢀⡀⠀⠀⠠⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⣡⣾⣿⣿⢏⣾⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⡴⠀⠀⠀⠀⠀⠠⠀⠰⣿⣿⣿⣷⣿⠿⠿⣿⣿⣭⡶⣫⠔⢻⢿⢇⣾⣿⣿⣿⣿⣿⣿
⣿⣿⣿⡿⢫⣽⠟⣋⠀⠀⠀⠀⣶⣦⠀⠀⠀⠈⠻⣿⣿⣿⣾⣿⣿⣿⣿⡿⣣⣿⣿⢸⣾⣿⣿⣿⣿⣿⣿⣿
⡿⠛⣹⣶⣶⣶⣾⣿⣷⣦⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠉⠛⠻⢿⣿⡿⠫⠾⠿⠋⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⡆⣠⢀⣴⣏⡀⠀⠀⠀⠉⠀⠀⢀⣠⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⠿⠛⠛⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣯⣟⠷⢷⣿⡿⠋⠀⠀⠀⠀⣵⡀⢠⡿⠋⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⢿⣿⣿⠂⠀⠀⠀⠀⠀⢀⣽⣿⣿⣿⣿⣿⣿⣿⣍⠛⠿⣿⣿⣿⣿⣿⣿

🎉 love you leonora]],
    },
    sections = {
      { section = "header" },
      { section = "keys",   gap = 1, padding = 1 },
      { section = "startup" },
    },
  },
  -- Picker disabled: project uses Telescope as primary picker
  picker = { enabled = false },
}

-- Set terminal keymaps and define highlight colors (called in init)
M.setup_init = function()
  -- Set terminal keymaps in terminal mode
  vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
      local opts = { buffer = 0, silent = true }
      -- Esc to exit terminal mode
      vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
      -- Auto enter insert mode
      vim.cmd("startinsert")
    end,
  })

  -- These need to be set after plugin loaded, handled by snacks automatically
  -- If manual setup needed:
  -- vim.ui.input = require("snacks").input
  -- vim.ui.select = require("snacks").picker.select

  -- Rainbow/scope/chunk highlight 颜色由 highlights.lua 统一管理（M.setup 中已调用）

  -- LSP Progress notifications using snacks notifier (simplified)
  vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin"|"report"|"end"}]]
      if not client or type(value) ~= "table" then
        return
      end

      local pct = value.kind == "end" and 100 or value.percentage or 0
      local msg = ("[%3d%%] %s"):format(pct, value.title or "")
      if value.message then
        msg = msg .. " " .. value.message
      end

      local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
      vim.notify(msg, value.kind == "end" and "info" or "info", {
        id = "lsp_progress_" .. client.id,
        title = client.name,
        opts = function(notif)
          notif.icon = value.kind == "end" and " "
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
      })
    end,
  })
end

return M
