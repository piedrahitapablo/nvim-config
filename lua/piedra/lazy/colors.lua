DefaultTheme = "onedark"
LualineDefaultTheme = "onedark"

function SetTheme(color)
    color = color or DefaultTheme
    vim.cmd.colorscheme(color)

    -- get the default value for the NormalFloat group
    local NormalFloat = vim.api.nvim_get_hl_by_name("NormalFloat", true)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none", fg = "LightBlue" })
    vim.api.nvim_set_hl(0, "WhiteSpace", { bg = "none", fg = "#3f3f3f" })
    vim.api.nvim_set_hl(0, "NonText", { bg = "none", fg = "#3f3f3f" })

    -- Treesitter context
    vim.api.nvim_set_hl(0, "TreesitterContextBottom", NormalFloat)
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
        lazy = true,
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
            })

            SetTheme()
        end,
    },
    {
        "levouh/tint.nvim",
        opts = {
            tint = -20,
            saturation = 0.5,
        },
    },
}
