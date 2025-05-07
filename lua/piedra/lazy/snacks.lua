return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        indent = { enabled = true },
        input = {
            enabled = true,
            win = {
                relative = "cursor",
                row = 1,
                col = 0,
            },
        },
        notifier = { enabled = true, style = "fancy" },
        picker = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        -- scroll = { enabled = true },
        words = { enabled = true },
    },
}
