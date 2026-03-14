-- ╭────────────────────────────────────────────────────────╮
-- │                   User Commands                        │
-- │                                                        │
-- │ Purpose: Encapsulate complex plugin interactions that  │
-- │          require multi-step logic, default parameters, │
-- │          or vim API calls beyond a simple require().   │
-- │ Note: Simple one-liner plugin calls should be inlined  │
-- │       directly in the keys definition instead.         │
-- ╰────────────────────────────────────────────────────────╯

local M = {}

-- ╭────────────────────────────────────────────────────────╮
-- │                Navigation Commands                     │
-- ╰────────────────────────────────────────────────────────╯

function M.harpoon_toggle()
  local harpoon = require("harpoon")
  harpoon.ui:toggle_quick_menu(harpoon:list())
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

-- ╭────────────────────────────────────────────────────────╮
-- │                  Editor Commands                       │
-- ╰────────────────────────────────────────────────────────╯

-- Dashboard
function M.dashboard()
  require("snacks").dashboard()
end

-- Buffer management
function M.bufdelete()
  require("snacks").bufdelete()
end

function M.bufdelete_other()
  require("snacks").bufdelete.other()
end

-- Terminal commands using snacks.nvim
---@param cmd? string Shell command (defaults to vim.o.shell)
---@param position? string Window position: "float"|"right"|"bottom"
---@param count? integer Terminal instance ID
local function open_terminal(cmd, position, count)
  cmd = cmd or vim.o.shell
  local opts = { count = count or 1 }
  if position then
    opts.win = { position = position }
    require("snacks").terminal.toggle(cmd, opts)
  else
    require("snacks").terminal.open(cmd, opts)
  end
end

function M.terminal(cmd) open_terminal(cmd, nil, 1) end
function M.terminal_float(cmd) open_terminal(cmd, "float", 2) end
function M.terminal_right(cmd) open_terminal(cmd, "right", 3) end
function M.terminal_bottom(cmd) open_terminal(cmd, "bottom", 4) end


-- ╭────────────────────────────────────────────────────────╮
-- │                  Setup Commands                        │
-- ╰────────────────────────────────────────────────────────╯

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
    local ok, project = pcall(require, "project_nvim")
    if ok then
      local root = project.get_project_root()
      if root then
        vim.cmd("cd " .. root)
      end
    end
  end, {
    desc = "Change directory to project root",
  })

end

return M
