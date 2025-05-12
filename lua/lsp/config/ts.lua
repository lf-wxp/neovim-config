local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
local volar_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

local opts = {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = volar_path,
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue",
  },
}

return opts;
