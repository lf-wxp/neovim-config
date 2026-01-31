-- reactive.nvim 配置
-- 根据编辑模式动态改变光标/cursorline样式

require("reactive").setup({
  builtin = {
    cursorline = false,  -- 启用 cursorline 高亮
    cursor = true,      -- 启用光标颜色
    modemsg = true,     -- 启用模式消息颜色
  },
  -- 自定义预设（可选）
  -- 使用内置预设，提供 Normal/Insert/Visual 等模式的不同颜色
})
