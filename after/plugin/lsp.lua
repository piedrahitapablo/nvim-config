local status, lsp = pcall(require, "lsp-zero")
if (not status) then
    print('lsp-zero is not installed')
    return
end

local status, cmp = pcall(require, 'cmp')
if (not status) then
    print('cmp is not installed')
    return
end

local status, null_ls = pcall(require, 'null-ls')
if (not status) then
    print('null-ls is not installed')
    return
end

lsp.preset("recommended")

-- lsp.set_server_config({
--   capabilities = {
--     textDocument = {
--       foldingRange = {
--         dynamicRegistration = false,
--         lineFoldingOnly = true
--       }
--     }
--   }
-- })

lsp.ensure_installed({
    'tsserver',
    'lua_ls',
    'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Esc>'] = cmp.mapping.close(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

local null_opts = lsp.build_options('null-ls', {
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

null_ls.setup({
    on_attach = null_opts.on_attach,
    sources = {
        -- null_ls.builtins.code_actions.eslint_d,
        -- null_ls.builtins.code_actions.gitsigns,
        -- null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.formatting.prismaFmt,
        -- null_ls.builtins.formatting.terraform_fmt,
        null_ls.builtins.formatting.trim_newlines,
        null_ls.builtins.formatting.trim_whitespace
    }
})

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

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
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                -- scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, float_opts)
        end
    })
    vim.o.updatetime = 1000
end)

vim.keymap.set("n", "<leader>lrr", "<cmd>LspRestart<cr>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    update_in_insert = false,
})

-- setup ufo, we need to move this to another file
-- local status, ufo = pcall(require, "ufo")
-- if not status then
--     print("ufo is not installed")
--     return
-- end

-- ufo.setup()

-- vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
-- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
