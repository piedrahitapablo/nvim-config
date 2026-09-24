return {
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            {
                "mason-org/mason.nvim",
                lazy = false,
                config = true,
            },
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "cssls",
                "docker_compose_language_service",
                "dockerls",
                "oxlint",
                -- "gopls",
                "html",
                "jsonls",
                "lua_ls",
                "marksman",
                -- "pyright",
                "basedpyright",
                "ruff",
                "rust_analyzer",
                "tailwindcss",
                "taplo",
                "terraformls",
                "tflint",
                "ts_ls",
            },
        },
    },
    {
        "saghen/blink.cmp",
        version = "1.*",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "default",
                ["<CR>"] = { "accept", "fallback" },
            },
            completion = {
                accept = {
                    auto_brackets = {
                        enabled = false,
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        lazy = false,
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>lf",
                function()
                    local conform = require("conform")
                    conform.format({ async = true }, function(err)
                        local mode = vim.api.nvim_get_mode().mode
                        if
                            err or not vim.startswith(string.lower(mode), "v")
                        then
                            return
                        end

                        vim.api.nvim_feedkeys(
                            vim.api.nvim_replace_termcodes(
                                "<Esc>",
                                true,
                                false,
                                true
                            ),
                            "n",
                            true
                        )
                    end)
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        ---@module "conform"
        ---@type conform.setupOpts
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "oxfmt", stop_after_first = true },
                javascriptreact = { "oxfmt", stop_after_first = true },
                typescript = { "oxfmt", stop_after_first = true },
                typescriptreact = { "oxfmt", stop_after_first = true },
                markdown = { "oxfmt", stop_after_first = true },
                json = { "oxfmt", stop_after_first = true },
                jsonc = { "oxfmt", stop_after_first = true },
                yaml = { "oxfmt", stop_after_first = true },
                html = { "oxfmt", stop_after_first = true },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
            -- format_on_save = { timeout_ms = 500 },
            formatters = {},
        },
    },
}
