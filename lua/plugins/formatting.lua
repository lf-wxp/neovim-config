-- ╭────────────────────────────────────────────────────────╮
-- │                  Formatting and Lint                   │
-- │                                                        │
-- │ Formatting Stack:                                      │
-- │   JS/TS: oxfmt (if .oxfmtrc.json exists) > prettierd  │
-- │   Lua:   stylua                                        │
-- │   Python: isort + black                                │
-- │   Rust:  rustfmt                                       │
-- │   CSS/JSON/HTML/YAML/MD: prettierd > prettier          │
-- │                                                        │
-- │ Linting Stack:                                         │
-- │   JS/TS: oxlint (via LSP server, not nvim-lint)        │
-- ╰────────────────────────────────────────────────────────╯

-- JS/TS filetypes that support oxfmt
local js_ts_filetypes = {
  "javascript", "javascriptreact",
  "typescript", "typescriptreact",
  "vue", "svelte", "astro",
}

-- Filetypes that use prettierd/prettier as formatter
local prettier_filetypes = { "css", "scss", "json", "html", "yaml", "markdown" }

return {
  -- ╭────────────────────────────────────────────────────────╮
  -- │ conform.nvim - Formatter                               │
  -- ╰────────────────────────────────────────────────────────╯
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    opts = function()
      -- oxfmt config file patterns
      local oxfmt_config_files = { ".oxfmtrc.json", ".oxfmtrc.jsonc" }

      -- buffer-local 缓存，避免每次 format_on_save 时重复做 fs_root + fs_stat
      ---@type table<integer, string|false> bufnr -> config_path or false (not found)
      local oxfmt_config_cache = {}

      --- Find oxfmt config file path from project root (with per-buffer cache)
      ---@param bufnr integer
      ---@return string|nil config_path Full path to oxfmt config file, or nil if not found
      local function find_oxfmt_config(bufnr)
        local cached = oxfmt_config_cache[bufnr]
        if cached ~= nil then
          return cached or nil -- false -> nil
        end

        local filepath = vim.api.nvim_buf_get_name(bufnr)
        if filepath == "" then
          oxfmt_config_cache[bufnr] = false
          return nil
        end
        local root = vim.fs.root(filepath, oxfmt_config_files)
        if not root then
          oxfmt_config_cache[bufnr] = false
          return nil
        end
        -- Find which config file exists in the root
        for _, config_file in ipairs(oxfmt_config_files) do
          local config_path = root .. "/" .. config_file
          if vim.uv.fs_stat(config_path) then
            oxfmt_config_cache[bufnr] = config_path
            return config_path
          end
        end
        oxfmt_config_cache[bufnr] = false
        return nil
      end

      -- buffer 被删除时清除缓存条目
      vim.api.nvim_create_autocmd("BufDelete", {
        callback = function(args)
          oxfmt_config_cache[args.buf] = nil
        end,
      })

      --- JS/TS formatter: oxfmt (if project supports) -> prettierd -> prettier
      ---@param bufnr integer
      ---@return string[]
      local function js_formatters(bufnr)
        if find_oxfmt_config(bufnr) then
          return { "oxfmt" }
        end
        return { "prettierd", "prettier", stop_after_first = true }
      end

      -- Build formatters_by_ft table
      local formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
      }

      -- Assign JS/TS formatter for all JS/TS filetypes
      for _, ft in ipairs(js_ts_filetypes) do
        formatters_by_ft[ft] = js_formatters
      end

      -- Assign prettier for CSS/JSON/HTML/YAML/MD filetypes
      for _, ft in ipairs(prettier_filetypes) do
        formatters_by_ft[ft] = { "prettierd", "prettier", stop_after_first = true }
      end

      return {
        -- Custom oxfmt formatter: explicitly pass --config to prevent
        -- oxfmt from auto-discovering non-oxfmt config files (e.g. vite.config.ts)
        formatters = {
          oxfmt = {
            prepend_args = function(_, ctx)
              local config_path = find_oxfmt_config(ctx.buf)
              if config_path then
                return { "--config", config_path }
              end
              return {}
            end,
          },
        },
        format_on_save = function(bufnr)
          -- Skip formatting for large files (> 200KB)
          local buf_name = vim.api.nvim_buf_get_name(bufnr)
          local stat = vim.uv.fs_stat(buf_name)
          if stat and stat.size > 200 * 1024 then
            return
          end

          -- Skip formatting for certain filetypes
          local ignore_filetypes = { "sql", "java" }
          if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
            return
          end

          return {
            timeout_ms = 500,
            lsp_format = "fallback",
          }
        end,
        formatters_by_ft = formatters_by_ft,
        -- Log level for debugging formatter issues
        log_level = vim.log.levels.WARN,
      }
    end,
  },

  -- nvim-lint removed: oxlint runs as LSP server, no standalone linters configured.
  -- Re-add nvim-lint when non-LSP linters (e.g. markdownlint, shellcheck) are needed.
}
