local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- very important, this needs to be set before the plugins are required
vim.g.mapleader = " "

local status, lazy = pcall(require, "lazy")
if not status then
    print("Lazy is not installed")
    return
end

lazy.setup({
    -- colorschemes
    {
        "jaredgorski/spacecamp",
        commit = "8945b4a2bfaaa16fbcee9f1d7c00cb9c1256b591",
        name = "spacecamp",
        lazy = true,
    },
    {
        "catppuccin/nvim",
        tag = "v1.7.0",
        name = "catppuccin",
        lazy = true,
    },
    {
        "Shatur/neovim-ayu",
        commit = "123dda90019215646700bfec70f178ad95820545",
        name = "ayu",
        lazy = true,
    },
    {
        "rose-pine/neovim",
        tag = "v3.0.1",
        name = "rose-pine",
        lazy = true,
    },
    {
        "navarasu/onedark.nvim",
        commit = "8e4b79b0e6495ddf29552178eceba1e147e6cecf",
    },

    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
    },
    {
        "smartpde/telescope-recent-files",
        commit = "6893cda11625254cc7dc2ea76e0a100c7deeb028",
    },

    -- lualine
    {
        "nvim-lualine/lualine.nvim",
        commit = "0a5a66803c7407767b799067986b4dc3036e1983",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
    },
    {
        "utilyre/barbecue.nvim",
        tag = "v1.2.0",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
    },

    -- files navigation
    {
        "stevearc/oil.nvim",
        tag = "v2.9.0",
        opts = {},
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },

    -- auto save sessions
    {
        "rmagatti/auto-session",
        commit = "af2219b9fa99c1d7ac409bd9eac094c459d3f52d",
    },
    {
        "rmagatti/session-lens",
        commit = "1b65d8e1bcd1836c5135cce118ba18d662a9dabd",
        dependencies = {
            "rmagatti/auto-session",
            "nvim-telescope/telescope.nvim",
        },
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        commit = "cdc613c630598779dc9f975bae12a4dc7c001950",
    },
    {
        "nvim-treesitter/playground",
        commit = "ba48c6a62a280eefb7c85725b0915e021a1a0749",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        commit = "5efba33af0f39942e426340da7bc15d7dec16474",
    },

    -- lsp and diagnostics
    {
        "VonHeikemen/lsp-zero.nvim",
        commit = "v3.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim" }, -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" }, -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional

            -- Snippets
            { "L3MON4D3/LuaSnip" }, -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        commit = "0010ea927ab7c09ef0ce9bf28c2b573fc302f5a7",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "jose-elias-alvarez/typescript.nvim",
        commit = "4de85ef699d7e6010528dcfbddc2ed4c2c421467",
    },
    {
        "jay-babu/mason-null-ls.nvim",
        tag = "v2.6.0",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
    },
    {
        "folke/trouble.nvim",
        tag = "v3.4.1",
        dependencies = "nvim-tree/nvim-web-devicons",
    },
    -- TODO: find a way to make this work properly
    -- code folds
    -- {
    --     "kevinhwang91/nvim-ufo",
    --     dependencies = "kevinhwang91/promise-async",
    -- },

    -- copilot
    -- "github/copilot.vim",

    -- tabnine
    -- {
    --     "codota/tabnine-nvim",
    --     build = "./dl_binaries.sh",
    -- },

    -- codeium
    {
        "Exafunction/codeium.vim",
        commit = "590d6eabc447088388a19459e2cb558fa1fd0c8c",
        event = "BufEnter",
    },

    -- undo
    {
        "mbbill/undotree",
        commit = "56c684a805fe948936cda0d1b19505b84ad7e065",
    },
    {
        "debugloop/telescope-undo.nvim",
        commit = "95b61c01ea3a4c9e8747731148e905bbcf0ccaee",
    },

    -- git
    {
        "tpope/vim-fugitive",
        commit = "64d6cafb9dcbacce18c26d7daf617ebb96b273f3",
    },
    {
        "lewis6991/gitsigns.nvim",
        tag = "v0.9.0",
    },
    {
        "akinsho/git-conflict.nvim",
        tag = "v2.0.0",
        config = true,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        tag = "v3.6.2",
    },

    -- code edition
    {
        "windwp/nvim-autopairs",
        commit = "c15de7e7981f1111642e7e53799e1211d4606cb9",
    },
    {
        "windwp/nvim-ts-autotag",
        commit = "06fe07d7523ba8c755fac7c913fceba43b1720ee",
    },
    {
        "tpope/vim-commentary",
        commit = "c4b8f52cbb7142ec239494e5a2c4a512f92c4d07",
    },
    {
        "tpope/vim-surround",
        commit = "3d188ed2113431cf8dac77be61b842acb64433d9",
    },

    -- previews
    {
        "iamcco/markdown-preview.nvim",
        commit = "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee",
        cmd = {
            "MarkdownPreviewToggle",
            "MarkdownPreview",
            "MarkdownPreviewStop",
        },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
})
