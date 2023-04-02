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

    -- telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- lualine
    use {
        'nvim-lualine/lualine.nvim',
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
    }
    use {
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
    }

    -- nvim-tree
    use { "tpope/vim-vinegar" }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    }

    -- auto save sessions
    use { 'rmagatti/auto-session' }

    -- treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use "nvim-treesitter/playground"

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

    -- copilot
    -- use 'github/copilot.vim'

    -- tabnine
    use {
        'codota/tabnine-nvim',
        run = "./dl_binaries.sh"
    }

    use { 'mbbill/undotree' }

    -- git
    use { 'tpope/vim-fugitive' }
    use { 'lewis6991/gitsigns.nvim' }

    use { "lukas-reineke/indent-blankline.nvim" }

    -- code edition
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'

    -- previews
    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }
end)
