function SetTheme(color)
    vim.cmd.colorscheme(color)
end

return {
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function(_, opts)
            require("onedark").setup(opts)

            SetTheme("onedark")
        end,
        opts = {
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
        },
    },
    {
        "levouh/tint.nvim",
        opts = {
            tint = -30,
            saturation = 0.2,
        },
    },
}
