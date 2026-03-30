" ~/.config/nvim/ginit.vim
" GUI-specific configuration for Neovim
" This file is loaded after init.lua when running in a GUI client

" Set guifont explicitly for Neovide
set guifont=Maple\ Mono\ NF\ CN:h14

" Load Neovide-specific configuration from Lua module
lua require('config.neovide')

" Additional GUI-specific settings can be added below if needed
