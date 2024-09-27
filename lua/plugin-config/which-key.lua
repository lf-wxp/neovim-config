local status, which_key = pcall(require, "which-key")
if not status then
  vim.notify("没有找到 which_key")
  return
end

which_key.setup({
  icons = {
    rules = {
      { pattern = "tree", icon = "󱏒", color = "green" },
      { pattern = "surround", icon = "", color = "orange" },
      { pattern = "resize", icon = "󰙖", color = "green" },
      { pattern = "rename", icon = "󰑕", color = "green" },
      { pattern = "flash", icon = "", color = "yellow" },
      { pattern = "paste", icon = "", color = "azure" },
      { pattern = "copy", icon = "", color = "azure" },
      { pattern = "highlight", icon = "󰸱", color = "azure" },
      { pattern = "scroll up", icon = "󰶣", color = "purple" },
      { pattern = "scroll down", icon = "󰶡", color = "purple" },
      { pattern = "navigate forward", icon = "", color = "purple" },
      { pattern = "navigate backward", icon = "󰕍", color = "purple" },
      { plugin = "crates.nvim", pattern = "crate", icon = "󰏖", color = "purple" },
      { pattern = "git", icon = "", color = "purple" },
      { pattern = "toggler", icon = "󰨚", color = "cyan" },
      { pattern = "harpoon", icon = "󱋡", color = "purple" },
      { pattern = "cursor", icon = "󰳽", color = "red" },
    },
  }
})
