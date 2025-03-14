function SetTheme(color)
    vim.cmd.colorscheme(color)
end

return {
    {
        "jaredgorski/spacecamp",
        name = "spacecamp",
        lazy = true,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
    },
    {
        "Shatur/neovim-ayu",
        name = "ayu",
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
    },
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local onedark = require("onedark")
            onedark.setup({
                style = "deep",
                transparent = true,
                highlights = {
                    Normal = {
                        bg = "none",
                    },
                    NormalFloat = {
                        bg = "none",
                    },
                    EndOfBuffer = {
                        bg = "none",
                        fg = "LightBlue",
                    },
                    WhiteSpace = {
                        bg = "none",
                        fg = "#3f3f3f",
                    },
                    NonText = {
                        bg = "none",
                        fg = "#3f3f3f",
                    },
                    WinSeparator = {
                        bg = "none",
                        fg = "#3f3f3f",
                    },
                },
            })

            SetTheme("onedark")
        end,
    },
    {
        "levouh/tint.nvim",
        opts = {
            tint = -20,
            saturation = 0.5,
        },
    },
    {
        "meanderingexile/nostromo-ui.nvim",
        opts = {
            theme = "dark",
            transparent = true,
            italics = {
                comments = false,
                keywords = false,
                functions = false,
                strings = false,
                variables = false,
            },
            overrides = {},
        },
    },
}
