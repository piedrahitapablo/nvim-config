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
        config = function(_, opts)
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local lsp_opts = { buffer = event.buf }

                    vim.keymap.set("n", "<leader>lre", "<cmd>LspRestart<cr>")
                    vim.keymap.set(
                        "n",
                        "K",
                        "<cmd>lua vim.lsp.buf.hover()<cr>",
                        lsp_opts
                    )
                    vim.keymap.set("n", "<leader>ld", function()
                        local telescope_builtin = require("telescope.builtin")
                        telescope_builtin.lsp_definitions()
                    end, lsp_opts)
                    vim.keymap.set(
                        "n",
                        "<leader>lD",
                        "<cmd>lua vim.lsp.buf.declaration()<cr>",
                        lsp_opts
                    )
                    vim.keymap.set("n", "<leader>li", function()
                        local telescope_builtin = require("telescope.builtin")
                        telescope_builtin.lsp_implementations()
                    end, lsp_opts)
                    vim.keymap.set("n", "<leader>lt", function()
                        local telescope_builtin = require("telescope.builtin")
                        telescope_builtin.lsp_type_definitions()
                    end, lsp_opts)
                    vim.keymap.set("n", "<leader>lrr", function()
                        local telescope_builtin = require("telescope.builtin")
                        telescope_builtin.lsp_references()
                    end, lsp_opts)
                    vim.keymap.set(
                        "n",
                        "<C-h>",
                        "<cmd>lua vim.lsp.buf.signature_help()<cr>",
                        lsp_opts
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>lrn",
                        "<cmd>lua vim.lsp.buf.rename()<cr>",
                        lsp_opts
                    )
                    -- managed by conform
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
                        lsp_opts
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>lx",
                        "<cmd>lua vim.diagnostic.open_float()<cr>",
                        lsp_opts
                    )
                    vim.keymap.set(
                        "n",
                        "[d",
                        "<cmd>lua vim.diagnostic.goto_prev()<cr>",
                        lsp_opts
                    )
                    vim.keymap.set(
                        "n",
                        "]d",
                        "<cmd>lua vim.diagnostic.goto_next()<cr>",
                        lsp_opts
                    )

                    -- show diagnostics on cursor hold
                    vim.api.nvim_create_autocmd("CursorHold", {
                        buffer = lsp_opts.buffer,
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
                end,
            })

            require("mason-lspconfig").setup(opts)
        end,
        opts = {
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
                            if client.workspace_folders then
                                local path = client.workspace_folders[1].name
                                if
                                    path ~= vim.fn.stdpath("config")
                                    and (
                                        vim.uv.fs_stat(path .. "/.luarc.json")
                                        or vim.uv.fs_stat(
                                            path .. "/.luarc.jsonc"
                                        )
                                    )
                                then
                                    return
                                end
                            end

                            client.config.settings.Lua = vim.tbl_deep_extend(
                                "force",
                                client.config.settings.Lua,
                                {
                                    runtime = {
                                        -- Tell the language server which version of Lua you're using (most
                                        -- likely LuaJIT in the case of Neovim)
                                        version = "LuaJIT",
                                        -- Tell the language server how to find Lua modules same way as Neovim
                                        -- (see `:h lua-module-load`)
                                        path = {
                                            "lua/?.lua",
                                            "lua/?/init.lua",
                                        },
                                    },
                                    -- Make the server aware of Neovim runtime files
                                    workspace = {
                                        checkThirdParty = false,
                                        library = {
                                            vim.env.VIMRUNTIME,
                                            -- Depending on the usage, you might want to add additional paths
                                            -- here.
                                            -- '${3rd}/luv/library'
                                            -- '${3rd}/busted/library'
                                        },
                                        -- Or pull in all of 'runtimepath'.
                                        -- NOTE: this is a lot slower and will cause issues when working on
                                        -- your own configuration.
                                        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                                        -- library = {
                                        --   vim.api.nvim_get_runtime_file('', true),
                                        -- }
                                    },
                                }
                            )
                        end,
                        settings = {
                            Lua = {},
                        },
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
                javascript = { "prettier", stop_after_first = true },
                javascriptreact = { "prettier", stop_after_first = true },
                typescript = { "prettier", stop_after_first = true },
                typescriptreact = { "prettier", stop_after_first = true },
                markdown = { "prettier", stop_after_first = true },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
            -- format_on_save = { timeout_ms = 500 },
            formatters = {},
        },
    },
}
