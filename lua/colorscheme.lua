local colorscheme = "zephyr"
-- gruvbox
-- zephyr
-- nord
-- onedark
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
  return
end

-- gruvbox 
vim.g.gruvbox_transparent = true
vim.g.gruvbox_transparent_sidebar = true
vim.g.gruvbox_contrast_dark = "soft"
