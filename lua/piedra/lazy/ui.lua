return {
    {
        "lukas-reineke/indent-blankline.nvim",
        tag = "v3.6.2",
        main = "ibl",
        enabled = false,
        opts = {
            enabled = false,
            -- show_start = true,
            -- show_end = false,
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        commit = "0a5a66803c7407767b799067986b4dc3036e1983",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
        opts = {
            options = {
                icons_enabled = true,
                theme = LualineDefaultTheme or "onedark",
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                disabled_filetypes = {
                    "packer",
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = {
                    {
                        "filename",
                        file_status = true, -- displays file status (readonly status, modified status)
                        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
                    },
                },
                lualine_x = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = {
                            error = " ",
                            warn = " ",
                            info = " ",
                            hint = " ",
                        },
                    },
                    "encoding",
                    "filetype",
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    {
                        "filename",
                        file_status = true, -- displays file status (readonly status, modified status)
                        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
                    },
                },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = {
                "fugitive",
                "nvim-tree",
            },
        },
    },
    {
        "utilyre/barbecue.nvim",
        tag = "v1.2.0",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {},
    },
}
