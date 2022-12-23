-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("正在安装Pakcer.nvim，请稍后...")
  paccker_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    -- "https://gitcode.net/mirrors/wbthomason/packer.nvim",
    install_path,
  })

  -- https://github.com/wbthomason/packer.nvim/issues/750
  local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
  end
  vim.notify("Pakcer.nvim 安装完毕")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("没有安装 packer.nvim")
  return
end

packer.startup({
  function(use)
    -- Packer 可以管理自己本身
    use("wbthomason/packer.nvim")
    --------------------- colorschemes --------------------
    -- tokyonight
    use("folke/tokyonight.nvim")
    -- OceanicNext
    use("mhartington/oceanic-next")
    use({
      "ellisonleao/gruvbox.nvim",
      requires = { "rktjmp/lush.nvim" },
    })
    use("olimorris/onedarkpro.nvim")
    use("catppuccin/nvim")
    use("sainnhe/edge")
    use("marko-cerovac/material.nvim")
    use("sainnhe/gruvbox-material")
    use("glepnir/zephyr-nvim")

    -- nvim-tree
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
    -- bufferline
    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } })
    -- lualine
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
    use("arkav/lualine-lsp-progress")

    -- telescope
    use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }
    -- telescope extensions
    use("LinArcX/telescope-env.nvim")
    use("nvim-telescope/telescope-ui-select.nvim")

    -- dashboard-nvim
    use("glepnir/dashboard-nvim")
    -- project
    use("ahmedkhalf/project.nvim")
    -- treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("lukas-reineke/indent-blankline.nvim")
    use("p00f/nvim-ts-rainbow")

    --------------------- LSP --------------------
    use { "williamboman/mason.nvim" }
    use { "williamboman/mason-lspconfig.nvim" }
    use { "neovim/nvim-lspconfig" }

    -- 补全引擎
    use("hrsh7th/nvim-cmp")
    -- snippet 引擎
    use("hrsh7th/vim-vsnip")
    -- 补全源
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
    use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }

    -- 常见编程语言代码段
    use("rafamadriz/friendly-snippets")

    -- ui
    use("onsails/lspkind-nvim")

    use("tami5/lspsaga.nvim")

    -- 代码格式化
    -- use("mhartington/formatter.nvim")
    use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })

    -- JSON 增强
    use("b0o/schemastore.nvim")

    -- typescript 增强
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim" })

    -- Rust 增强
    use("simrat39/rust-tools.nvim")

    -- surround
    use("ur4ltz/surround.nvim")
    -- Comment
    use("numToStr/Comment.nvim")
    -- nvim-autopairs
    use("windwp/nvim-autopairs")

    use("akinsho/toggleterm.nvim")

    use("lewis6991/gitsigns.nvim")

    use("rmagatti/auto-session")

    use {
      'rmagatti/session-lens',
      requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
    }

    -- use("xiyaowong/nvim-transparent")

    use({
      "nvim-pack/nvim-spectre",
      requires = {
        "nvim-lua/plenary.nvim", -- Lua 开发模块
        "BurntSushi/ripgrep" -- 文字查找
      }
    })
    use("mg979/vim-visual-multi")

    use("norcalli/nvim-colorizer.lua")

    use("folke/which-key.nvim")

    use("kdheepak/lazygit.nvim")

    use { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }

    use("karb94/neoscroll.nvim")

    use { "phaazon/hop.nvim",
      branch = 'v1', -- optional but strongly recommended
    }

    use("lewis6991/spellsitter.nvim")

    use("rmagatti/goto-preview")

    use("simrat39/symbols-outline.nvim")

    -- use("weilbith/nvim-code-action-menu")

    use("stevearc/dressing.nvim")

    -- use("petertriho/nvim-scrollbar")

    use("chentoast/marks.nvim")

    use("ThePrimeagen/harpoon")

    use("j-hui/fidget.nvim")

    use("folke/trouble.nvim")

    use {
      "saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function()
        require('crates').setup()
      end,
    }
    use { "kevinhwang91/nvim-hlslens" }

    -- use {
    --   'romgrk/barbar.nvim',
    --   requires = {'kyazdani42/nvim-web-devicons'}
    -- }
    use { "nvim-telescope/telescope-symbols.nvim" }

    use { "nvim-telescope/telescope-hop.nvim" }

    -- winbar
    use {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig"
    }

    use { "sunjon/shade.nvim" }

  end,
  config = {
    -- 并发数限制
    max_jobs = 16,
    -- 自定义源
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    },
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
