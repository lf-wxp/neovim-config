local status, fidget = pcall(require, "fidget")
if not status then
  vim.notify("没有找到 fidget")
  return
end

fidget.setup({
  text = {
    spinner = "square_corners", -- animation shown when tasks are ongoing
    done = "✔", -- character shown when all tasks are complete
    commenced = "Started", -- message shown when task starts
    completed = "Completed", -- message shown when task completes
  },
  align = {
    bottom = true, -- align fidgets along bottom edge of buffer
    right = true,  -- align fidgets along right edge of buffer
  },
  timer = {
    spinner_rate = 125,  -- frame rate of spinner animation, in ms
    fidget_decay = 2000, -- how long to keep around empty fidget, in ms
    task_decay = 1000,   -- how long to keep around completed task, in ms
  },
  window = {
    relative = "win", -- where to anchor, either "win" or "editor"
    blend = 20,       -- &winblend for the window
    zindex = nil,     -- the zindex value for the window
    border = "none",  -- style of border for the fidget window
  },
  fmt = {
    leftpad = true,       -- right-justify text in fidget box
    stack_upwards = true, -- list of tasks grows upwards
    max_width = 0,        -- maximum width of the fidget box
    fidget =              -- function to format fidget title
        function(fidget_name, spinner)
          return string.format("%s %s", spinner, fidget_name)
        end,
    task = -- function to format each task line
        function(task_name, message, percentage)
          return string.format(
            "%s%s [%s]",
            message,
            percentage and string.format(" (%s%%)", percentage) or "",
            task_name
          )
        end,
  },
})

vim.api.nvim_set_hl(0, 'FidgetTitle', { ctermfg = 0, fg = "#d16d9e" })
-- vim.cmd("highlight FidgetTitle ctermfg=0 guifg=#d16d9e")
vim.api.nvim_set_hl(0, 'FidgetTask', { ctermfg = 0, fg = "#CBA6F7" })
-- vim.cmd("highlight FidgetTask ctermfg=0 guifg=#CBA6F7")
