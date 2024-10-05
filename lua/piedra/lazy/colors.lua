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
        commit = "8945b4a2bfaaa16fbcee9f1d7c00cb9c1256b591",
        name = "spacecamp",
        lazy = true,
    },
    {
        "catppuccin/nvim",
        tag = "v1.7.0",
        name = "catppuccin",
        lazy = true,
    },
    {
        "Shatur/neovim-ayu",
        commit = "123dda90019215646700bfec70f178ad95820545",
        name = "ayu",
        lazy = true,
    },
    {
        "rose-pine/neovim",
        tag = "v3.0.1",
        name = "rose-pine",
        lazy = true,
    },
    {
        "folke/tokyonight.nvim",
        tag = "v4.8.0",
        lazy = true,
    },
    {
        "navarasu/onedark.nvim",
        commit = "8e4b79b0e6495ddf29552178eceba1e147e6cecf",
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
        commit = "02bd0527a315a80e4e25bb2dd7b6994fb0daae01",
        opts = {
            tint = -20,
            saturation = 0.5,
        },
    },
}
