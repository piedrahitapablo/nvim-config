--- @param event vim.api.keyset.create_autocmd.callback_args
local function setup_ts_ls(event)
    local lsp_client = vim.lsp.get_client_by_id(event.data.client_id)
    if lsp_client == nil or lsp_client.name ~= "ts_ls" then
        return
    end

    lsp_client.server_capabilities.documentFormattingProvider = false
    lsp_client.server_capabilities.documentFormattingRangeProvider = false

    for cmd_name, cmd_opts in pairs({
        TsLsAddMissingImports = {
            desc = "ts_ls: Add missing imports",
            cmd = "source.addMissingImports.ts",
            keymap = "<leader>tmi",
        },
        TsLsRemoveUnused = {
            desc = "ts_ls: Remove unused imports",
            cmd = "source.removeUnused.ts",
            keymap = "<leader>tmu",
        },
        TsLsOrganizeImports = {
            desc = "ts_ls: Organize imports (sort and remove unused)",
            cmd = "source.organizeImports.ts",
            keymap = "<leader>tmo",
        },
    }) do
        vim.api.nvim_buf_create_user_command(0, cmd_name, function()
            vim.lsp.buf.code_action({
                apply = true,
                context = {
                    diagnostics = {},
                    only = {
                        ---@diagnostic disable-next-line: assign-type-mismatch
                        cmd_opts.cmd,
                    },
                },
            })
        end, {
            desc = cmd_opts.desc,
        })

        vim.keymap.set(
            "n",
            cmd_opts.keymap,
            string.format("<cmd>%s<CR>", cmd_name),
            {
                buffer = event.buf,
                noremap = true,
                silent = true,
                desc = cmd_opts.desc,
            }
        )
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local lsp_opts = { buffer = event.buf }

        -- need to do this setup here because nvim-lspconfig already declares a
        -- on_attach function and apparntly that one takes precedence over the
        -- one in lsp/ts_ls.lua in this config
        setup_ts_ls(event)

        vim.keymap.set("n", "<leader>lre", "<cmd>LspRestart<cr>", lsp_opts)
        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover({ border = "rounded" })
        end, lsp_opts)
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
                vim.diagnostic.open_float(nil, {
                    focus = false,
                    close_events = {
                        "BufLeave",
                        "CursorMoved",
                        "InsertEnter",
                        "FocusLost",
                    },
                    border = "rounded",
                    source = "always",
                })
            end,
        })

        vim.diagnostic.config({
            virtual_text = false,
            underline = true,
            update_in_insert = false,
        })

        vim.o.updatetime = 1000
    end,
})
