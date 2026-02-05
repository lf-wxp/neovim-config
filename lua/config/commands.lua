-- lua/config/commands.lua 
-- User Commands Module - Exposes all plugin Lua APIs for use in keymaps via <cmd> syntax
-- This module satisfies the requirement: "keymaps中不要出现具体插件的lua的函数调用"

local M = {}

-- ╭──────────────────────────────────────────────────────────╮
-- │                      Flash Commands                       │
-- ╰──────────────────────────────────────────────────────────╯

function M.flash_jump()
  require("flash").jump()
end

function M.flash_treesitter_search()
  require("flash").treesitter_search()
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                    Yanky Commands                         │
-- ╰──────────────────────────────────────────────────────────╯

function M.yank_history()
  require("telescope").extensions.yank_history.yank_history()
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                    Treesj Commands                        │
-- ╰──────────────────────────────────────────────────────────╯

function M.treesj_toggle()
  require("treesj").toggle()
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                   Sniprun Commands                        │
-- ╰──────────────────────────────────────────────────────────╯

function M.sniprun()
  require("sniprun").run("n")
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                     Oil Commands                          │
-- ╰──────────────────────────────────────────────────────────╯

function M.oil_float()
  require("oil").toggle_float()
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                  Grug-far Commands                        │
-- ╰──────────────────────────────────────────────────────────╯

function M.grug_far()
  require("grug-far").open({ prefills = { flags = "" } })
end

function M.grug_far_file()
  require("grug-far").open({ prefills = { flags = vim.fn.expand("%") } })
end

function M.grug_far_word()
  require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                   Smart-splits Commands                   │
-- ╰──────────────────────────────────────────────────────────╯

function M.win_left()
  require("smart-splits").move_cursor_left()
end

function M.win_right()
  require("smart-splits").move_cursor_right()
end

function M.win_up()
  require("smart-splits").move_cursor_up()
end

function M.win_down()
  require("smart-splits").move_cursor_down()
end

function M.resize_left()
  require("smart-splits").resize_left()
end

function M.resize_right()
  require("smart-splits").resize_right()
end

function M.resize_up()
  require("smart-splits").resize_up()
end

function M.resize_down()
  require("smart-splits").resize_down()
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                    Snacks Commands                        │
-- ╰──────────────────────────────────────────────────────────╯

function M.dashboard()
  Snacks.dashboard()
end

function M.bufdelete()
  Snacks.bufdelete()
end

function M.bufdelete_other()
  Snacks.bufdelete.other()
end

function M.lazygit()
  Snacks.lazygit()
end

function M.terminal()
  Snacks.terminal()
end

function M.toggle_terminal()
  Snacks.terminal(nil, { cwd = vim.fn.expand("%:p:h") })
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                    Crates Commands                        │
-- ╰──────────────────────────────────────────────────────────╯

function M.crate_toggle()
  require("crates").toggle()
end

function M.crate_reload()
  require("crates").reload()
end

function M.crate_versions()
  require("crates").show_versions_popup()
end

function M.crate_features()
  require("crates").show_features_popup()
end

function M.crate_update()
  require("crates").update_crate()
end

function M.crate_upgrade()
  require("crates").upgrade_crate()
end

function M.crate_upgrade_all()
  require("crates").upgrade_all_crates()
end

function M.crate_expand()
  require("crates").expand_plain_crate_to_inline_table()
end

function M.crate_extract()
  require("crates").extract_crate_into_table()
end

function M.crate_open()
  require("crates").open_crate_homepage()
end

function M.crate_doc()
  require("crates").open_documentation()
end

function M.crate_repo()
  require("crates").open_repository()
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                   Harpoon Commands                        │
-- ╰──────────────────────────────────────────────────────────╯

function M.harpoon_add()
  require("harpoon"):list():add()
end

function M.harpoon_toggle()
  local harpoon = require("harpoon")
  harpoon.ui:toggle_quick_menu(harpoon:list())
end

function M.harpoon_prev()
  require("harpoon"):list():prev()
end

function M.harpoon_next()
  require("harpoon"):list():next()
end

function M.harpoon_select(n)
  require("harpoon"):list():select(n)
end
function M.crate_dependencies()
  require("crates").show_dependencies_popup()
end

function M.crate_crates_io()
  require("crates").open_crates_io()
end

return M
