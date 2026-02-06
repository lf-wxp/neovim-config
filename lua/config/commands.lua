-- lua/config/commands.lua
-- User Commands Module - Exposes all plugin Lua APIs for use in keymaps via <cmd> syntax
-- This module satisfies the requirement: "keymaps中不要出现具体插件的lua的函数调用"
--
-- Commands are organized by functionality:
-- 1. File System Commands
-- 2. Navigation Commands
-- 3. Editor Commands
-- 4. Git Commands
-- 5. Language Commands

local M = {}

-- ╭──────────────────────────────────────────────────────────╮
-- │                File System Commands                       │
-- ╰──────────────────────────────────────────────────────────╯

function M.oil_float()
  require("oil").toggle_float()
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                  Navigation Commands                      │
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

function M.harpoon_telescope()
  local harpoon = require("harpoon")
  local harpoon_files = harpoon:list()

  local conf = require("telescope.config").values
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
-- │                    Editor Commands                        │
-- ╰──────────────────────────────────────────────────────────╯

-- Terminal commands using snacks.nvim
function M.terminal(cmd)
  cmd = cmd or vim.o.shell
  require("snacks").terminal.open(cmd, { count = 1 })
end

function M.terminal_float(cmd)
  cmd = cmd or vim.o.shell
  require("snacks").terminal.toggle(cmd, { win = { position = "float" }, count = 2 })
end

function M.terminal_right(cmd)
  cmd = cmd or vim.o.shell
  require("snacks").terminal.toggle(cmd, { win = { position = "right" }, count = 3 })
end

function M.terminal_bottom(cmd)
  cmd = cmd or vim.o.shell
  require("snacks").terminal.toggle(cmd, { win = { position = "bottom" }, count = 4 })
end

-- ╭──────────────────────────────────────────────────────────╮

function M.flash_jump()
  require("flash").jump()
end

function M.flash_treesitter_search()
  require("flash").treesitter_search()
end

function M.yank_history()
  require("telescope").extensions.yank_history.yank_history()
end

function M.treesj_toggle()
  require("treesj").toggle()
end

function M.sniprun()
  require("sniprun").run("n")
end

function M.dashboard()
  require("snacks").dashboard()
end

function M.bufdelete()
  require("snacks").bufdelete()
end

function M.bufdelete_other()
  require("snacks").bufdelete.other()
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                      Git Commands                         │
-- ╰──────────────────────────────────────────────────────────╯

function M.lazygit()
  require("snacks").lazygit()
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                  Language Commands                        │
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

function M.crate_dependencies()
  require("crates").show_dependencies_popup()
end

function M.crate_crates_io()
  require("crates").open_crates_io()
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                    Setup Commands                         │
-- ╰──────────────────────────────────────────────────────────╯

M.setup = function()
  -- Set option for current buffer
  vim.api.nvim_create_user_command("SetOptionForBuf", function(opts)
    local args = vim.split(opts.args, " ")
    vim.opt_local[args[1]] = args[2]
  end, {
    nargs = "*",
    desc = "Set option for current buffer",
  })

  -- Change directory to current file's parent
  vim.api.nvim_create_user_command("SetCwd", function()
    vim.cmd("cd " .. vim.fn.expand("%:p:h"))
  end, {
    desc = "Change directory to current file's parent",
  })

  -- Change directory to project root
  vim.api.nvim_create_user_command("SetCwdToRoot", function()
    local status, ok = pcall(require, "project_nvim")
    if status then
      local root = ok.get_project_root()
      if root then
        vim.cmd("cd " .. root)
      end
    end
  end, {
    desc = "Change directory to project root",
  })

  -- Change directory to current buffer
  vim.api.nvim_create_user_command("SetCwdToBuf", function()
    vim.cmd("cd " .. vim.fn.expand("%:p:h"))
  end, {
    desc = "Change directory to current buffer",
  })
end

return M
