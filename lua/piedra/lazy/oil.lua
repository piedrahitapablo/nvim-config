return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            {
                "<leader>pb",
                function()
                    vim.cmd.Oil(vim.fn.getcwd())
                end,
            },
            { "<leader>pv", ":Oil<CR>" },
            { "<leader>vpv", ":vertical Oil<CR>" },
            { "<leader>fpv", ":Oil --float<CR>" },
        },
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            delete_to_trash = true,
            columns = {
                "icon",
                "permissions",
                -- "size",
                -- "mtime",
            },
            view_options = {
                -- Show files and directories that start with "."
                show_hidden = true,
                -- This function defines what is considered a "hidden" file
                is_hidden_file = function(name)
                    return vim.startswith(name, ".")
                end,
                -- This function defines what will never be shown, even when `show_hidden` is set
                is_always_hidden = function()
                    return false
                end,
            },
            float = {
                -- Padding around the floating window
                padding = 10,
                max_width = 0,
                max_height = 0,
                border = "rounded",
                win_options = {
                    winblend = 10,
                },
            },
        },
        lsp_file_methods = {
            autosave_changes = "unmodified",
        },
    },
}
