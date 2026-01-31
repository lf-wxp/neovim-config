-- ╭──────────────────────────────────────────────────────────╮
-- │                    Neovide Config                         │
-- ╰──────────────────────────────────────────────────────────╯

if not vim.g.neovide then
  return -- Only load in Neovide
end

-- Window settings
vim.g.neovide_opacity = 1
vim.g.neovide_normal_opacity = 1
vim.g.neovide_remember_window_size = true
vim.g.neovide_no_idle = true
vim.g.neovide_window_blurred = true

-- Cursor effects
vim.g.neovide_cursor_smooth_blink = true
vim.g.neovide_cursor_vfx_mode = "torpedo"
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_unfocused_outline_width = 0.125

-- Floating window effects
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_floating_corner_radius = 2.0

-- Scroll animation
vim.g.neovide_scroll_animation_length = 0.3
