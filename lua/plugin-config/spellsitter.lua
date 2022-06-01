
local status, spellsitter = pcall(require, "spellsitter")
if not status then
  vim.notify("没有找到 spellsitter")
  return
end

spellsitter.setup({
  enable = true,
})
