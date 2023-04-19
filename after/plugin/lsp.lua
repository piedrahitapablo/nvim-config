local status, lsp_zero = pcall(require, "lsp-zero")
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

lsp_zero.preset("recommended")

lsp_zero.ensure_installed({
    'spectral',
    'prismals',
    -- 'black',
    'cssls',
    'docker_compose_language_service',
    'dockerls',
    'eslint',
    'gopls',
    'html',
    -- 'json_ls',
    'lua_ls',
    'marksman',
    -- 'prettierd',
    'pyright',
    'rust_analyzer',
    -- 'stylua',
    'tailwindcss',
    'taplo',
    'terraformls',
    'tflint',
    'tsserver',
})

-- Fix Undefined global 'vim'
lsp_zero.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp_zero.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Esc>'] = cmp.mapping.close(),
})

lsp_zero.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp_zero.set_preferences({
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

local null_opts = lsp_zero.build_options('null-ls', {
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
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.trim_newlines,
        null_ls.builtins.formatting.trim_whitespace
    }
})

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
lsp_zero.on_attach(function(client, bufnr)
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

lsp_zero.setup()

vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    update_in_insert = false,
})
