-- ╭────────────────────────────────────────────────────────╮
-- │           LuaSnip - Snippet Engine Config              │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local keys = require("config.keymaps")
  local ls = require("luasnip")
  local types = require("luasnip.util.types")

  -- https://github.com/rafamadriz/friendly-snippets/
  require("luasnip.loaders.from_vscode").lazy_load()

  ls.config.set_config({
    history = true,
    update_events = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "<--", "Error" } },
        },
      },
    },
  })

  local opt = { noremap = true, silent = true }

  vim.keymap.set({ "i", "s" }, keys.snip.expand_jumpable, function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, opt)
  vim.keymap.set({ "i", "s" }, keys.snip.jumpable, function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, opt)
  vim.keymap.set({ "i", "s" }, keys.snip.choice_active_up, function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, opt)
  vim.keymap.set({ "i", "s" }, keys.snip.choice_active_down, function()
    if ls.choice_active() then
      ls.change_choice(-1)
    end
  end, opt)
end

return M
