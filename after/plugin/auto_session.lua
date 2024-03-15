local session = require("auto-session")

vim.o.sessionoptions =
    "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

session.setup({
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "~/code", "~/Downloads", "/" },
})
