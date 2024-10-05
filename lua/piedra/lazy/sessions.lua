return {
    {
        "rmagatti/auto-session",
        commit = "af2219b9fa99c1d7ac409bd9eac094c459d3f52d",
        config = function()
            vim.o.sessionoptions =
                "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

            local session = require("auto-session")
            session.setup({
                log_level = "error",
                auto_session_suppress_dirs = {
                    "~/",
                    "~/code",
                    "~/Downloads",
                    "/",
                },
            })
        end,
    },
}
