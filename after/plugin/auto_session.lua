local session = require("auto-session")

vim.o.sessionoptions =
    "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

session.setup({
    log_level = "error",
    pre_save_cmds = { "NvimTreeClose" },
    auto_session_suppress_dirs = { "~/", "~/code", "~/Downloads", "/" },
})
