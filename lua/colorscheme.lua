colorscheme = "zephyr"
-- tokyonight
-- OceanicNext
-- gruvbox
-- zephyr
-- nord
-- onedark
-- nightfox
-- gruvbox-material
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
  return
end

-- grubox-material
vim.g.gruvbox_material_transparent_background = 1

-- gruvbox 
vim.g.gruvbox_transparent = true
vim.g.gruvbox_transparent_sidebar = true
vim.g.gruvbox_contrast_dark = "soft"

-- edge
vim.g.edge_style = "neon"
vim.g.edge_enable_italic = 1
vim.g.edge_disable_italic_comment = 1
vim.g.edge_show_eob = 1
vim.g.edge_better_performance = 1
vim.g.edge_transparent_background = 1
