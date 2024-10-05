return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local treesitter = require("nvim-treesitter.configs")
            treesitter.setup({
                ensure_installed = {
                    "tsx",
                    "toml",
                    "json",
                    "yaml",
                    -- "swift",
                    "css",
                    "html",
                    "lua",
                    "vim",
                    "c",
                    -- "help",
                    "rust",
                    "graphql",
                    -- needed to highlight TODOs and FIXMEs
                    "comment",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                    disable = {},
                },
            })

            local parser_configs =
                require("nvim-treesitter.parsers").get_parser_configs()
            parser_configs.tsx.filetype_to_parsername =
                { "javascript", "typescript.tsx" }

            vim.treesitter.language.register("terraform", "terraform-vars")
        end,
    },
    { "nvim-treesitter/playground" },
    {
        "nvim-treesitter/nvim-treesitter-context",
        -- did not work using keys and opts
        config = function()
            local treesitter_context = require("treesitter-context")
            treesitter_context.setup({
                enable = false,
                max_lines = 0,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 20,
                trim_scope = "outer",
                mode = "cursor",
                separator = nil,
                zindex = 20,
            })

            vim.keymap.set("n", "<leader>kts", "<cmd>TSContextToggle<cr>")
        end,
    },
}
