return {
    {
        "folke/trouble.nvim",
        tag = "v3.4.1",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            local trouble = require("trouble")
            trouble.setup({
            height = 20,
            })

            vim.keymap.set(
                "n",
                "<leader>xw",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                { silent = true, noremap = true }
            )
            vim.keymap.set(
                "n",
                "<leader>xd",
                "<cmd>TroubleToggle document_diagnostics<cr>",
                { silent = true, noremap = true }
            )
        end,
    },
}
