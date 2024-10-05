return {
    {
        "VonHeikemen/lsp-zero.nvim",
        commit = "v3.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim", lazy = false }, -- Optional
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

            -- Null-ls
            {
                "jose-elias-alvarez/null-ls.nvim",
                commit = "0010ea927ab7c09ef0ce9bf28c2b573fc302f5a7",
            },
            {
                "jay-babu/mason-null-ls.nvim",
                tag = "v2.6.0",
            },
            {
                "jose-elias-alvarez/typescript.nvim",
                commit = "4de85ef699d7e6010528dcfbddc2ed4c2c421467",
            },
        },
        config = function()
            vim.lsp.set_log_level("info")

            vim.keymap.set("n", "<leader>lrr", "<cmd>LspRestart<cr>")
            vim.keymap.set("n", "<leader>lf", function()
                vim.lsp.buf.format({ timeout_ms = 3000 })
            end)

            local lsp_zero = require("lsp-zero")
            lsp_zero.preset("recommended")

            local telescope_builtin = require("telescope.builtin")
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup(
                    "user_lsp_attach",
                    { clear = true }
                ),
                callback = function(event)
                    local opts = { buffer = event.buf, remap = false }

                    vim.keymap.set("n", "gd", function()
                        telescope_builtin.lsp_definitions()
                    end, opts)
                    vim.keymap.set("n", "K", function()
                        vim.lsp.buf.hover()
                    end, opts)
                    vim.keymap.set("n", "<leader>vws", function()
                        vim.lsp.buf.workspace_symbol()
                    end, opts)
                    vim.keymap.set("n", "<leader>vd", function()
                        vim.diagnostic.open_float()
                    end, opts)
                    vim.keymap.set("n", "[d", function()
                        vim.diagnostic.goto_prev()
                    end, opts)
                    vim.keymap.set("n", "]d", function()
                        vim.diagnostic.goto_next()
                    end, opts)
                    vim.keymap.set("n", "<leader>vca", function()
                        vim.lsp.buf.code_action()
                    end, opts)
                    vim.keymap.set("n", "<leader>vrr", function()
                        telescope_builtin.lsp_references()
                    end, opts)
                    vim.keymap.set("n", "<leader>vrn", function()
                        vim.lsp.buf.rename()
                    end, opts)
                    vim.keymap.set("i", "<C-h>", function()
                        vim.lsp.buf.signature_help()
                    end, opts)

                    -- show diagnostics on cursor hold
                    vim.api.nvim_create_autocmd("CursorHold", {
                        buffer = event.buf,
                        callback = function()
                            -- TODO: add formatter using these icons and a newline at the end
                            -- mirror format from trouble
                            -- {
                            --     error = "",
                            --     warning = "",
                            --     hint = "",
                            --     information = "",
                            --     other = "﫠"
                            -- }

                            vim.diagnostic.open_float(nil, {
                                focusable = false,
                                close_events = {
                                    "BufLeave",
                                    "CursorMoved",
                                    "InsertEnter",
                                    "FocusLost",
                                },
                                border = "rounded",
                                source = "always",
                                -- scope = 'cursor',
                            })
                        end,
                    })
                    vim.o.updatetime = 1000
                end,
            })

            local mason = require("mason")
            mason.setup({})

            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup({
                ensure_installed = {
                    "cssls",
                    "docker_compose_language_service",
                    "dockerls",
                    "eslint",
                    "gopls",
                    "html",
                    "jsonls",
                    "lua_ls",
                    "marksman",
                    "prismals",
                    "pyright",
                    "ruff_lsp",
                    "rust_analyzer",
                    "tailwindcss",
                    "taplo",
                    "terraformls",
                    "tflint",
                    "tsserver",
                },
                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup({})
                    end,
                    lua_ls = function()
                        lspconfig.lua_ls.setup({
                            settings = {
                                Lua = {
                                    runtime = {
                                        version = "LuaJIT",
                                    },
                                    diagnostics = {
                                        globals = { "vim" },
                                    },
                                    workspace = {
                                        library = {
                                            vim.env.VIMRUNTIME,
                                        },
                                    },
                                },
                            },
                        })
                    end,
                },
            })

            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local cmp_format = lsp_zero.cmp_format()
            cmp.setup({
                sources = {
                    { name = "path" },
                    { name = "nvim_lsp" },
                    -- { name = "luasnip", keyword_length = 2 },
                    { name = "buffer", keyword_length = 3 },
                },
                formatting = cmp_format,
                mapping = lsp_zero.defaults.cmp_mappings({
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<Esc>"] = cmp.mapping.close(),
                }),
            })

            lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())

            local null_ls = require("null-ls")
            null_ls.setup({
                on_attach = lsp_zero.build_options("null-ls", {
                    -- uncomment this to enable format on save
                    -- on_attach = function(client)
                    --   if client.resolved_capabilities.document_formatting then
                    --     vim.api.nvim_create_autocmd("BufWritePre", {
                    --       desc = "Auto format before save",
                    --       pattern = "<buffer>",
                    --       callback = vim.lsp.buf.formatting_sync,
                    --     })
                    --   end
                    -- end
                }).on_attach,
                sources = {
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.diagnostics.ruff,
                    null_ls.builtins.formatting.ruff,
                    null_ls.builtins.formatting.stylua,
                    require("typescript.extensions.null-ls.code-actions"),
                },
            })

            local mason_null_ls = require("mason-null-ls")
            mason_null_ls.setup({
                ensure_installed = {
                    "prettier",
                    "ruff",
                    "stylua",
                },
                automatic_installation = false,
            })

            lsp_zero.set_preferences({
                sign_icons = {
                    -- error = "E",
                    -- warn = "W",
                    -- hint = "H",
                    -- info = "I",
                    error = "",
                    warn = "",
                    hint = "",
                    info = "",
                },
            })
            lsp_zero.setup()

            vim.diagnostic.config({
                virtual_text = false,
                underline = true,
                update_in_insert = false,
            })
        end,
    },
}
