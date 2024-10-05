return {
    {
        "rmagatti/auto-session",
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
