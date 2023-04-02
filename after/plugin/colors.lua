DefaultTheme = "onedark"
LualineDefaultTheme = "onedark"

function SetColorScheme(color)
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
