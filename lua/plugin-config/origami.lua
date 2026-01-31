-- https://github.com/chrisgrieser/nvim-origami
-- Modern fold management plugin
local status, origami = pcall(require, "origami")
if not status then
    vim.notify("origami not found")
    return
end

-- Set fold level to ensure files open unfolded
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
-- Ensure fold is enabled (set to true to use folds, but level 99 means default no folding)
vim.opt.foldenable = true
-- Use expr fold method, let origami manage fold expression
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.require'origami'.foldexpr()"

origami.setup({
    -- Disable LSP folds to avoid Treesitter auto-creating folds
    useLspFoldsWithTreesitterFallback = {
        enabled = false,
    },
    -- Do not keep folds across sessions
    keepFoldsAcrossSessions = false,
    -- Disable auto-fold behavior (default folds comments and imports)
    autoFold = {
        enabled = false,
        kinds = {}, -- Empty array, do not auto-fold any type
    },
    -- Disable built-in foldtext, use custom function
    foldtext = {
        enabled = false,
    },
    -- Enable fold keymaps
    foldKeymaps = {
        setup = true,
        closeOnlyOnFirstColumn = false,
        scrollLeftOnCaret = false,
    },
})

-- Custom foldtext function, modern style with icon beautification
local function custom_foldtext()
    local foldstart = vim.v.foldstart
    local foldend = vim.v.foldend
    local foldlevel = vim.v.foldlevel
    
    -- Get first line content of fold
    local first_line = vim.fn.getline(foldstart)
    -- Remove leading whitespace
    first_line = first_line:match("^%s*(.-)$") or first_line
    
    -- Calculate folded lines count
    local folded_lines = foldend - foldstart + 1
    
    -- Modern style icon configuration
    local folder_icon = "󰘖"      -- Folder/code block icon nf-md-folder_table
    local code_icon = ""         -- Code icon nf-fa-code
    local lines_icon = "󰯌"        -- Line count icon nf-md-calendar_text
    local arrow_icon = ""        -- Arrow icon nf-fa-caret_right
    local separator = "│"         -- Separator
    
    -- Adjust indent decoration based on fold level
    local indent = string.rep("  ", foldlevel - 1)
    
    -- Build modern style prefix: icon + code icon + indent
    local prefix = indent .. folder_icon .. " " .. code_icon .. " "
    
    -- Build modern style suffix: separator + line count + arrow
    local suffix = " " .. separator .. " " .. lines_icon .. " " .. folded_lines .. " " .. arrow_icon
    
    -- Get current window width
    local win_width = vim.api.nvim_win_get_width(0)
    local prefix_len = vim.fn.strdisplaywidth(prefix)
    local suffix_len = vim.fn.strdisplaywidth(suffix)
    
    -- Max content width limit
    local max_content_width = 50
    local fixed_spacing = 1  -- Fixed spacing between content and suffix
    
    -- Calculate available content space
    local content_width = math.min(max_content_width, win_width - prefix_len - suffix_len - fixed_spacing)
    if content_width < 10 then
        content_width = 10
    end
    
    -- Truncate content
    local content = first_line
    if vim.fn.strdisplaywidth(content) > content_width then
        content = vim.fn.strcharpart(content, 0, content_width - 3) .. "..."
    end
    
    -- Pad spaces for alignment
    local content_actual_width = vim.fn.strdisplaywidth(content)
    local pad_len = content_width - content_actual_width
    if pad_len < 0 then pad_len = 0 end
    local padding = string.rep(" ", pad_len)
    
    return prefix .. content .. padding .. suffix
end

-- Set global foldtext
_G.custom_foldtext = custom_foldtext

-- Defer foldtext setting to ensure it takes effect after origami is fully initialized
vim.defer_fn(function()
    vim.opt.foldtext = "v:lua.custom_foldtext()"
end, 100)

-- Ensure foldtext is set on every buffer enter
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "FileType" }, {
    pattern = "*",
    callback = function()
        -- Use defer to ensure setting takes effect
        vim.defer_fn(function()
            vim.opt_local.foldtext = "v:lua.custom_foldtext()"
        end, 10)
    end,
    desc = "Ensure custom foldtext is set",
})
