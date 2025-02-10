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
            ---@diagnostic disable-next-line: unused-local
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
                -- vim.keymap.set(
                --     { "n", "x" },
                --     "<leader>lf",
                --     "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
                --     opts
                -- )
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

                -- override the default select function to show the source of
                -- the code action
                -- https://github.com/neovim/neovim/issues/30710
                local original_vim_ui_select = vim.ui.select
                ---@diagnostic disable-next-line: duplicate-set-field
                vim.ui.select = function(items, select_opts, on_choice)
                    if select_opts.kind ~= "codeaction" then
                        return original_vim_ui_select(
                            items,
                            select_opts,
                            on_choice
                        )
                    end

                    -- original fn: https://github.com/neovim/neovim/blob/release-0.10/runtime/lua/vim/lsp/buf.lua#L812
                    ---@param item {action: lsp.Command|lsp.CodeAction, ctx: lsp.CodeActionContext}
                    select_opts.format_item = function(item)
                        local formatted = item.action.title
                            :gsub("\r\n", "\\r\\n")
                            :gsub("\n", "\\n")

                        local client_id = item.ctx and item.ctx.client_id
                        if client_id then
                            local action_client =
                                vim.lsp.get_client_by_id(client_id)
                            local source_name = action_client
                                    and action_client.name
                                or "unknown"

                            formatted = formatted .. " [" .. source_name .. "]"
                        end

                        return formatted
                    end

                    original_vim_ui_select(items, select_opts, on_choice)
                end

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
                    "ruff",
                    "rust_analyzer",
                    "tailwindcss",
                    "taplo",
                    "terraformls",
                    "tflint",
                    "ts_ls",
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
                    ts_ls = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.ts_ls.setup({
                            on_attach = function(client, bufnr)
                                client.server_capabilities.documentFormattingProvider =
                                    false
                                client.server_capabilities.documentFormattingRangeProvider =
                                    false

                                local opts = {
                                    buffer = bufnr,
                                    noremap = true,
                                    silent = true,
                                }

                                vim.keymap.set(
                                    "n",
                                    "<leader>tmi",
                                    "<cmd>TsLsAddMissingImports<CR>",
                                    opts
                                )
                                vim.keymap.set(
                                    "n",
                                    "<leader>tmu",
                                    "<cmd>TsLsRemoveUnused<CR>",
                                    opts
                                )
                                vim.keymap.set(
                                    "n",
                                    "<leader>tmo",
                                    "<cmd>TsLsOrganizeImports<CR>",
                                    opts
                                )
                            end,
                            commands = {
                                TsLsAddMissingImports = {
                                    function()
                                        vim.lsp.buf.code_action({
                                            apply = true,
                                            context = {
                                                diagnostics = {},
                                                only = {
                                                    ---@diagnostic disable-next-line: assign-type-mismatch
                                                    "source.addMissingImports.ts",
                                                },
                                            },
                                        })
                                    end,
                                    description = "Typescript LS: Add missing imports",
                                },
                                TsLsRemoveUnused = {
                                    function()
                                        vim.lsp.buf.code_action({
                                            apply = true,
                                            context = {
                                                diagnostics = {},
                                                only = {
                                                    ---@diagnostic disable-next-line: assign-type-mismatch
                                                    "source.removeUnused.ts",
                                                },
                                            },
                                        })
                                    end,
                                    description = "Typescript LS: Remove unused imports",
                                },
                                TsLsOrganizeImports = {
                                    function()
                                        vim.lsp.buf.code_action({
                                            apply = true,
                                            context = {
                                                diagnostics = {},
                                                only = {
                                                    ---@diagnostic disable-next-line: assign-type-mismatch
                                                    "source.organizeImports.ts",
                                                },
                                            },
                                        })
                                    end,
                                    description = "Typescript LS: Organize imports (sort and remove unused)",
                                },
                            },
                        })
                    end,
                },
            })
        end,
    },
}
