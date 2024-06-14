local cmp = require("cmp")
local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_null_ls = require("mason-null-ls")
local null_ls = require("null-ls")
local telescope_status, telescope = pcall(require, "telescope.builtin")
local typescript_status, typescript = pcall(require, "typescript")
local ufo_status, ufo = pcall(require, "ufo")

lsp_zero.preset("recommended")

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
    callback = function(event)
        local opts = { buffer = event.buf, remap = false }

        vim.keymap.set("n", "gd", function()
            if not telescope_status then
                vim.lsp.buf.definition()
            else
                telescope.lsp_definitions()
            end
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
            if not telescope_status then
                vim.lsp.buf.references()
            else
                telescope.lsp_references()
            end
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

                local float_opts = {
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
                }
                vim.diagnostic.open_float(nil, float_opts)
            end,
        })
        vim.o.updatetime = 1000
    end,
})

mason.setup({})
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

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_format = lsp_zero.cmp_format()
cmp.setup({
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

lsp_zero.set_preferences({
    sign_icons = {
        error = "E",
        warn = "W",
        hint = "H",
        info = "I",
    },
})

local null_opts = lsp_zero.build_options("null-ls", {
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
})

mason_null_ls.setup({
    ensure_installed = {
        "black",
        -- eslint should be preferred since its more efficient
        -- "eslint_d",
        "mypy",
        "prettier",
        -- prettier should be preferred since its more efficient
        -- "prettierd",
        "ruff",
        "stylua",
    },
    automatic_installation = false,
    handlers = {},
})
null_ls.setup({
    on_attach = null_opts.on_attach,
    sources = {
        -- null_ls.builtins.code_actions.eslint,
        -- null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.formatting.eslint,
        -- null_ls.builtins.formatting.prettier,
        -- FIXME: find a good way to add this conditionally
        require("typescript.extensions.null-ls.code-actions"),
    },
})

vim.keymap.set("n", "<leader>lrr", "<cmd>LspRestart<cr>")
vim.keymap.set("n", "<leader>lf", function()
    vim.lsp.buf.format({ timeout_ms = 3000 })
end)

lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())

if ufo_status then
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Using ufo provider need remap `zR` and `zM`.
    vim.keymap.set("n", "zR", ufo.openAllFolds)
    vim.keymap.set("n", "zM", ufo.closeAllFolds)

    ufo.setup()

    lsp_zero.set_server_config({
        capabilities = {
            textDocument = {
                foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true,
                },
            },
        },
    })
end

lsp_zero.setup()

if typescript_status then
    typescript.setup({
        server = {
            on_attach = function(client, bufnr)
                -- You can find more commands in the documentation:
                -- https://github.com/jose-elias-alvarez/typescript.nvim#commands
                vim.keymap.set(
                    "n",
                    "<leader>tmi",
                    "<cmd>TypescriptAddMissingImports<cr>",
                    { buffer = bufnr }
                )
                vim.keymap.set(
                    "n",
                    "<leader>tmu",
                    "<cmd>TypescriptRemoveUnused<cr>",
                    { buffer = bufnr }
                )
            end,
        },
    })
end

vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    update_in_insert = false,
})
