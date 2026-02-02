return {
    {
        "supermaven-inc/supermaven-nvim",
        opts = {
            color = {
                -- suggestion_color = "PaleTurquoise3",
                suggestion_color = "lightgreen",
                cterm = 244,
            },
        },
    },
    -- {
    --     "yetone/avante.nvim",
    --     event = "VeryLazy",
    --     keys = {
    --         {
    --             "<leader>an",
    --             "<cmd>AvanteChatNew<cr>",
    --             desc = "avante: new chat",
    --         },
    --     },
    --     version = false,
    --     opts = {
    --         provider = "claude",
    --         auto_suggestions_provider = "claude",
    --         providers = {
    --             claude = {
    --                 endpoint = "https://api.anthropic.com",
    --                 model = "claude-sonnet-4-20250514",
    --                 -- model = "claude-3-5-haiku-20241022",
    --                 extra_request_body = {
    --                     temperature = 0.75,
    --                     max_tokens = 20480,
    --                 },
    --             },
    --         },
    --         file_selector = {
    --             provider = "snacks",
    --         },
    --         windows = {
    --             input = {
    --                 prefix = "",
    --                 height = 20,
    --             },
    --         },
    --     },
    --     build = "make",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "MunifTanjim/nui.nvim",
    --         "hrsh7th/nvim-cmp",
    --         "nvim-tree/nvim-web-devicons",
    --         {
    --             "MeanderingProgrammer/render-markdown.nvim",
    --             opts = {
    --                 file_types = { "markdown", "Avante" },
    --             },
    --             ft = { "markdown", "Avante" },
    --         },
    --     },
    -- },
}
