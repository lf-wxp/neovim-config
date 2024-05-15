local status, harpoon = pcall(require, "harpoon")
if not status then
  vim.notify("没有找到 harpoon")
  return
end

local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true })
end

local keys = require("keybindings")
harpoon:setup({
  settings = {
    save_on_toggle = true,
    sync_on_ui_close = true,
  }
})

map("n", keys.harpoon.append, function() harpoon:list():add() end)
map("n", keys.harpoon.toggle, function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
map("n", keys.harpoon.prev, function() harpoon:list():prev() end)
map("n", keys.harpoon.next, function() harpoon:list():next() end)
map("n", keys.harpoon.n1, function() harpoon:list():select(1) end)
map("n", keys.harpoon.n2, function() harpoon:list():select(2) end)
map("n", keys.harpoon.n3, function() harpoon:list():select(3) end)
map("n", keys.harpoon.n4, function() harpoon:list():select(4) end)
map("n", keys.harpoon.n5, function() harpoon:list():select(5) end)
map("n", keys.harpoon.n6, function() harpoon:list():select(6) end)


-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end
vim.keymap.set("n", "<leader>ng", function() toggle_telescope(harpoon:list()) end,
  { desc = "Open harpoon window" })
