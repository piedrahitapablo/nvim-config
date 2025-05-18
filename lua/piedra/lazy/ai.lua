return {
    {
        "supermaven-inc/supermaven-nvim",
        opts = {
            color = {
                suggestion_color = "lightgreen",
                cterm = 244,
            },
        },
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>an",
                "<cmd>AvanteChatNew<cr>",
                desc = "avante: new chat",
            },
        },
        version = false,
        opts = {
            provider = "claude",
            auto_suggestions_provider = "claude",
            claude = {
                endpoint = "https://api.anthropic.com",
                model = "claude-3-5-sonnet-20241022",
                -- model = "claude-3-7-sonnet-latest",
                temperature = 0,
                max_tokens = 4096,
            },
            file_selector = {
                provider = "snacks",
            },
        },
        build = "make",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-tree/nvim-web-devicons",
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
}
