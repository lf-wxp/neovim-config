-- ╭──────────────────────────────────────────────────────────╮
-- │      codecompanion - AI Coding Assistant Config           │
-- ╰──────────────────────────────────────────────────────────╯

local M = {}

M.setup = function()
  local status, codecompanion = pcall(require, "codecompanion")
  if not status then
    vim.notify("codecompanion not found", vim.log.levels.ERROR)
    return
  end

  codecompanion.setup({
    adapters = {
      deepseek = function()
        return require("codecompanion.adapters").extend("deepseek", {
          env = {
            api_key = "DEEPSEEK_API_KEY",
          },
        })
      end,
    },
    display = {
      chat = {
        window = {
          border = "solid",
          borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
        },
      },
      action_palette = {
        opts = {
          borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
        }
      },
    },
    strategies = {
      chat = {
        adapter = "deepseek",
      },
      inline = { adapter = "deepseek" },
      agent = { adapter = "deepseek" },
    },
  })
end

return M
