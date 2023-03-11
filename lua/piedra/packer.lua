local status, packer = pcall(require, "packer")
if (not status) then
    print("Packer is not installed")
    return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    -- colorschemes
    use {
        'jaredgorski/spacecamp',
        as = 'spacecamp',
    }
    use {
        "catppuccin/nvim",
        as = "catppuccin"
    }
    use {
        "Shatur/neovim-ayu",
        as = "ayu"
    }
    use {
        'rose-pine/neovim',
        as = 'rose-pine'
    }
    use 'navarasu/onedark.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        'nvim-lualine/lualine.nvim',
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
    }

    use { "tpope/vim-vinegar" }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    }

    use { 'rmagatti/auto-session' }

    -- treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use "nvim-treesitter/playground"

    -- folding
    -- use {
    --     'kevinhwang91/nvim-ufo',
    --     requires = 'kevinhwang91/promise-async'
    -- }

    -- lsp and diagnostics
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            { 'williamboman/mason.nvim' }, -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-buffer' }, -- Optional
            { 'hrsh7th/cmp-path' }, -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' }, -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' }, -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }
    use {
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    }
    use { 'MunifTanjim/prettier.nvim' }
    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
    }

    use { 'mbbill/undotree' }

    use { 'tpope/vim-fugitive' }
    use { 'lewis6991/gitsigns.nvim' }

    use { "lukas-reineke/indent-blankline.nvim" }

    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'

    use "ellisonleao/glow.nvim"
    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }
end)
