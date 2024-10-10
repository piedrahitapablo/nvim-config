return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        lazy = true,
        config = false,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "onsails/lspkind.nvim" },
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")

            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                sources = {
                    { name = "supermaven" },
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "buffer", keyword_length = 3 },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<Esc>"] = cmp.mapping.close(),
                    ["<Tab>"] = cmp.mapping.select_next_item({
                        behavior = "select",
                    }),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item({
                        behavior = "select",
                    }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    -- ["<C-f>"] = cmp_action.vim_snippet_jump_forward(),
                    -- ["<C-b>"] = cmp_action.vim_snippet_jump_backward(),
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        show_labelDetails = true,
                        symbol_map = { Supermaven = "" },
                    }),
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            local lsp_attach = function(client, bufnr)
                local opts = { buffer = bufnr }

                vim.keymap.set("n", "<leader>lre", "<cmd>LspRestart<cr>")
                vim.keymap.set(
                    "n",
                    "K",
                    "<cmd>lua vim.lsp.buf.hover()<cr>",
                    opts
                )
                vim.keymap.set("n", "<leader>ld", function()
                    local telescope_builtin = require("telescope.builtin")
                    telescope_builtin.lsp_definitions()
                end, opts)
                vim.keymap.set(
                    "n",
                    "<leader>lD",
                    "<cmd>lua vim.lsp.buf.declaration()<cr>",
                    opts
                )
                vim.keymap.set("n", "<leader>li", function()
                    local telescope_builtin = require("telescope.builtin")
                    telescope_builtin.lsp_implementations()
                end, opts)
                vim.keymap.set("n", "<leader>lt", function()
                    local telescope_builtin = require("telescope.builtin")
                    telescope_builtin.lsp_type_definitions()
                end, opts)
                vim.keymap.set("n", "<leader>lrr", function()
                    local telescope_builtin = require("telescope.builtin")
                    telescope_builtin.lsp_references()
                end, opts)
                vim.keymap.set(
                    "n",
                    "<C-h>",
                    "<cmd>lua vim.lsp.buf.signature_help()<cr>",
                    opts
                )
                vim.keymap.set(
                    "n",
                    "<leader>lrn",
                    "<cmd>lua vim.lsp.buf.rename()<cr>",
                    opts
                )
                vim.keymap.set(
                    { "n", "x" },
                    "<leader>lf",
                    "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
                    opts
                )
                vim.keymap.set(
                    "n",
                    "<leader>lca",
                    "<cmd>lua vim.lsp.buf.code_action()<cr>",
                    opts
                )
                vim.keymap.set(
                    "n",
                    "<leader>lx",
                    "<cmd>lua vim.diagnostic.open_float()<cr>",
                    opts
                )
                vim.keymap.set(
                    "n",
                    "[d",
                    "<cmd>lua vim.diagnostic.goto_prev()<cr>",
                    opts
                )
                vim.keymap.set(
                    "n",
                    "]d",
                    "<cmd>lua vim.diagnostic.goto_next()<cr>",
                    opts
                )

                -- show diagnostics on cursor hold
                vim.api.nvim_create_autocmd("CursorHold", {
                    buffer = bufnr,
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

                vim.diagnostic.config({
                    virtual_text = false,
                    underline = true,
                    update_in_insert = false,
                })

                vim.lsp.handlers["textDocument/hover"] =
                    vim.lsp.with(vim.lsp.handlers.hover, {
                        border = "rounded",
                    })

                vim.o.updatetime = 1000
            end

            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = lsp_attach,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

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
                    -- "prismals",
                    "pyright",
                    "ruff_lsp",
                    "rust_analyzer",
                    "tailwindcss",
                    "taplo",
                    "terraformls",
                    "tflint",
                    -- "ts_ls",
                },
                handlers = {
                    function(server_name)
                        local lspconfig = require("lspconfig")
                        lspconfig[server_name].setup({})
                    end,
                    lua_ls = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup({
                            on_init = function(client)
                                lsp_zero.nvim_lua_settings(client, {})
                            end,
                        })
                    end,
                },
            })
        end,
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        lazy = false,
        keys = {
            {
                "<leader>tmi",
                "<cmd>TSToolsAddMissingImports<cr>",
                desc = "TS: Add missing imports",
            },
            {
                "<leader>tmu",
                "<cmd>TSToolsRemoveUnused<cr>",
                desc = "TS: Remove unused",
            },
            {
                "<leader>tmo",
                "<cmd>TSToolsOrganizeImports<cr>",
                desc = "TS: Sort and remove unused imports",
            },
        },
        opts = {
            settings = {
                expose_as_code_action = "all",
            },
        },
    },
}
