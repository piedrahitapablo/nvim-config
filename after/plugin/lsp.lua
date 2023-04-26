local cmp = require("cmp")
local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")
local mason_null_ls = require("mason-null-ls")
local null_ls = require("null-ls")
local telescope_status, telescope = pcall(require, "telescope.builtin")
local typescript_status, typescript = pcall(require, "typescript")

lsp_zero.preset("recommended")

lsp_zero.ensure_installed({
    "spectral",
    "prismals",
    "cssls",
    "docker_compose_language_service",
    "dockerls",
    -- this server is not working
    -- 'eslint',
    "gopls",
    "html",
    "lua_ls",
    "marksman",
    "pyright",
    "rust_analyzer",
    "tailwindcss",
    "taplo",
    "terraformls",
    "tflint",
    "tsserver",
})

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp_zero.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Esc>"] = cmp.mapping.close(),
})

lsp_zero.setup_nvim_cmp({
    mapping = cmp_mappings,
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
        "eslint_d",
        "json_ls",
        "prettierd",
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
        -- FIXME: find a good way to add this conditionally
        require("typescript.extensions.null-ls.code-actions"),
    },
})

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

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
end)

vim.keymap.set("n", "<leader>lrr", "<cmd>LspRestart<cr>")
vim.keymap.set("n", "<leader>lf", function()
    vim.lsp.buf.format({ timeout_ms = 3000 })
end)

if typescript_status then
    lsp_zero.skip_server_setup({ "tsserver" })
end

lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())

lsp_zero.setup()

if typescript_status then
    typescript.setup({
        server = {
            on_attach = function(client, bufnr)
                -- You can find more commands in the documentation:
                -- https://github.com/jose-elias-alvarez/typescript.nvim#commands

                vim.keymap.set(
                    "n",
                    "<leader>ci",
                    "<cmd>TypescriptAddMissingImports<cr>",
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
