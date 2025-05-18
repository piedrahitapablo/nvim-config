return {
    {
        "supermaven-inc/supermaven-nvim",
        opts = {},
    },
    -- {
    --     "olimorris/codecompanion.nvim",
    --     event = "VeryLazy",
    --     lazy = false,
    --     opts = {
    --         strategies = {
    --             chat = {
    --                 adapter = "anthropic",
    --             },
    --             inline = {
    --                 adapter = "anthropic",
    --             },
    --         },
    --     },
    --     config = function(_, opts)
    --         require("codecompanion").setup(opts)
    --         vim.cmd([[cab cc CodeCompanion]])
    --     end,
    --     keys = {
    --         {
    --             "<C-a>",
    --             "<cmd>CodeCompanionActions<cr>",
    --             mode = { "n", "v" },
    --             desc = "CodeCompanionActions",
    --         },
    --         {
    --             "<leader>aa",
    --             "<cmd>CodeCompanionChat Toggle<cr>",
    --             mode = { "n", "v" },
    --             desc = "CodeCompanionChat",
    --         },
    --         {
    --             "ga",
    --             "<cmd>CodeCompanionChat Add<cr>",
    --             mode = { "n", "v" },
    --             desc = "CodeCompanionChatAdd",
    --         },
    --     },
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-treesitter/nvim-treesitter",
    --         {
    --             "MeanderingProgrammer/render-markdown.nvim",
    --             opts = {
    --                 file_types = { "markdown", "codecompanion" },
    --             },
    --             ft = { "markdown", "codecompanion" },
    --         },
    --     },
    -- },
    -- {
    --     "ravitemer/mcphub.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --     },
    --     -- commented out to have mcphub loaded before the avante config runs
    --     -- cmd = "MCPHub",
    --     build = "volta install mcp-hub@latest",
    --     opts = {
    --         config = vim.fn.expand("~/.config/nvim/mcphub/servers.json"),
    --         extensions = {
    --             avante = {
    --                 make_slash_commands = true,
    --             },
    --         },
    --     },
    -- },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        keys = {
            {
                "<leader>an",
                "<cmd>AvanteChatNew<cr>",
                desc = "avante: new chat",
            },
        },
        -- version = "*",
        config = function(_, opts)
            -- mcphub setup
            -- opts.system_prompt = function()
            --     local hub = require("mcphub").get_hub_instance()
            --     return hub:get_active_servers_prompt()
            -- end
            -- opts.custom_tools = function()
            --     return {
            --         require("mcphub.extensions.avante").mcp_tool(),
            --     }
            -- end
            -- opts.disabled_tools = {
            --     "list_files",
            --     "search_files",
            --     "read_file",
            --     "create_file",
            --     "rename_file",
            --     "delete_file",
            --     "create_dir",
            --     "rename_dir",
            --     "delete_dir",
            --     "bash",
            -- }
            -- mcphub setup

            require("avante").setup(opts)
        end,
        opts = {
            provider = "claude",
            auto_suggestions_provider = "claude",
            claude = {
                endpoint = "https://api.anthropic.com",
                -- model = "claude-3-5-sonnet-20241022",
                model = "claude-3-7-sonnet-latest",
                temperature = 0,
                max_tokens = 4096,
            },
            behaviour = {
                auto_suggestions = false,
                auto_set_highlight_group = true,
                auto_set_keymaps = true,
                auto_apply_diff_after_generation = false,
                support_paste_from_clipboard = false,
                minimize_diff = true,
                enable_token_counting = true,
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
            -- {
            --     "HakonHarnes/img-clip.nvim",
            --     event = "VeryLazy",
            --     opts = {
            --         default = {
            --             embed_image_as_base64 = false,
            --             prompt_for_file_name = false,
            --             drag_and_drop = {
            --                 insert_mode = true,
            --             },
            --         },
            --     },
            --     ft = { "Avante" },
            -- },
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
