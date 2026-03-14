-- ╭────────────────────────────────────────────────────────╮
-- │     lua-language-server - Lua LSP Configuration        │
-- │                                                        │
-- │ Note: Workspace library is handled by lazydev.nvim     │
-- │       which provides superior Neovim API completion    │
-- ╰────────────────────────────────────────────────────────╯

local opts = {
  settings = {
    Lua = {
      runtime = {
        -- LuaJIT for Neovim
        version = "LuaJIT",
      },
      diagnostics = {
        -- Recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Let lazydev.nvim handle workspace library for better performance
        -- (avoids scanning entire Neovim runtime on every startup)
        checkThirdParty = false,
      },
      -- Disable telemetry
      telemetry = {
        enable = false,
      },
      -- Enable inlay hints for Lua
      hint = {
        enable = true,
        setType = true,
      },
    },
  },
}

return opts
