vim.o.sessionoptions =
    "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return {
    {
        "rmagatti/auto-session",
        lazy = false,
        keys = {
            {
                "<leader>sl",
                "<cmd>SessionSearch<CR>",
                desc = "Session search",
            },
        },
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            log_level = "error",
            suppressed_dirs = {
                "~/",
                "~/code",
                "~/Downloads",
                "/",
            },
        },
    },
}
