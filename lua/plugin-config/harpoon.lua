local status, harpoon = pcall(require, "harpoon")
if not status then
  vim.notify("没有找到 harpoon")
  return
end

harpoon.setup({
  -- mark_branch = true,
  -- menu = {
  --   width = vim.api.nvim_win_get_width(0) - 4,
  --   height = 20
  -- }
})

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
-- vim.keymap.set("n", "<leader>ng", function() toggle_telescope(harpoon:list()) end,
--     { desc = "Open harpoon window" })
