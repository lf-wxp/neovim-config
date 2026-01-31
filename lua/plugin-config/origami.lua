-- https://github.com/chrisgrieser/nvim-origami
-- 现代化的折叠管理插件
local status, origami = pcall(require, "origami")
if not status then
    vim.notify("没有找到 origami")
    return
end

-- 设置折叠级别，确保文件打开时不折叠
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
-- 确保折叠功能启用（设置为true才能使用折叠，但级别设为99表示默认不折叠）
vim.opt.foldenable = true
-- 使用 expr 折叠方式，让 origami 管理折叠表达式
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.require'origami'.foldexpr()"

origami.setup({
    -- 禁用 LSP folds，避免 Treesitter 自动创建折叠
    useLspFoldsWithTreesitterFallback = {
        enabled = false,
    },
    -- 不跨会话保持折叠状态
    keepFoldsAcrossSessions = false,
    -- 禁用自动折叠行为（默认会折叠 comment 和 imports）
    autoFold = {
        enabled = false,
        kinds = {}, -- 空数组，不自动折叠任何类型
    },
    -- 禁用内置 foldtext，使用自定义函数
    foldtext = {
        enabled = false,
    },
    -- 启用折叠快捷键
    foldKeymaps = {
        setup = true,
        closeOnlyOnFirstColumn = false,
        scrollLeftOnCaret = false,
    },
})

-- 自定义 foldtext 函数，现代风格带图标美化
local function custom_foldtext()
    local foldstart = vim.v.foldstart
    local foldend = vim.v.foldend
    local foldlevel = vim.v.foldlevel
    
    -- 获取折叠首行的内容
    local first_line = vim.fn.getline(foldstart)
    -- 去除前导空白
    first_line = first_line:match("^%s*(.-)$") or first_line
    
    -- 计算折叠行数
    local folded_lines = foldend - foldstart + 1
    
    -- 现代风格图标配置
    local folder_icon = "󰘖"      -- 文件夹/代码块图标 nf-md-folder_table
    local code_icon = ""         -- 代码图标 nf-fa-code
    local lines_icon = "󰯌"        -- 行数图标 nf-md-calendar_text
    local arrow_icon = ""        -- 箭头图标 nf-fa-caret_right
    local separator = "│"         -- 分隔线
    
    -- 根据折叠层级调整缩进装饰
    local indent = string.rep("  ", foldlevel - 1)
    
    -- 构建现代风格前缀：图标 + 代码图标 + 缩进
    local prefix = indent .. folder_icon .. " " .. code_icon .. " "
    
    -- 构建现代风格后缀：分隔线 + 行数 + 箭头
    local suffix = " " .. separator .. " " .. lines_icon .. " " .. folded_lines .. " " .. arrow_icon
    
    -- 获取当前窗口宽度
    local win_width = vim.api.nvim_win_get_width(0)
    local prefix_len = vim.fn.strdisplaywidth(prefix)
    local suffix_len = vim.fn.strdisplaywidth(suffix)
    
    -- 内容最大宽度限制
    local max_content_width = 50
    local fixed_spacing = 1  -- 内容和后缀之间的固定间距
    
    -- 计算内容可用空间
    local content_width = math.min(max_content_width, win_width - prefix_len - suffix_len - fixed_spacing)
    if content_width < 10 then
        content_width = 10
    end
    
    -- 截断内容
    local content = first_line
    if vim.fn.strdisplaywidth(content) > content_width then
        content = vim.fn.strcharpart(content, 0, content_width - 3) .. "..."
    end
    
    -- 填充空格对齐
    local content_actual_width = vim.fn.strdisplaywidth(content)
    local pad_len = content_width - content_actual_width
    if pad_len < 0 then pad_len = 0 end
    local padding = string.rep(" ", pad_len)
    
    return prefix .. content .. padding .. suffix
end

-- 设置全局 foldtext
_G.custom_foldtext = custom_foldtext

-- 延迟设置 foldtext，确保在 origami 完全初始化后生效
vim.defer_fn(function()
    vim.opt.foldtext = "v:lua.custom_foldtext()"
end, 100)

-- 确保每次进入缓冲区时都设置 foldtext
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "FileType" }, {
    pattern = "*",
    callback = function()
        -- 使用延迟确保设置生效
        vim.defer_fn(function()
            vim.opt_local.foldtext = "v:lua.custom_foldtext()"
        end, 10)
    end,
    desc = "Ensure custom foldtext is set",
})
