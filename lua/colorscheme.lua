-- vim.o.background = "dark"
local colorscheme = "edge"
-- tokyonight
-- OceanicNext
-- gruvbox
-- zephyr
-- nord
-- onedark
-- nightfox
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
  return
end

-- gruvbox 
vim.g.gruvbox_transparent = true
vim.g.gruvbox_transparent_sidebar = true

-- edge
vim.g.edge_style = "aura"
vim.g.edge_enable_italic = 1
vim.g.edge_disable_italic_comment = 1
vim.g.edge_show_eob = 1
vim.g.edge_better_performance = 1
vim.g.edge_transparent_background = 1
