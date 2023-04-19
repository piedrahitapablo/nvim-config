local session = require("auto-session")

vim.o.sessionoptions =
    "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

local function CloseFugitive()
    if vim.fn.buflisted(vim.fn.bufname("fugitive:///*/.git//$")) ~= 0 then
        vim.cmd([[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]])
    end
end

session.setup({
    log_level = "error",
    pre_save_cmds = { "NvimTreeClose", CloseFugitive },
    auto_session_suppress_dirs = { "~/", "~/code", "~/Downloads", "/" },
})
