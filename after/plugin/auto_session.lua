local status, session = pcall(require, 'auto-session')
if (not status) then
    print('auto-session is not installed')
    return
end

session.setup {
    log_level = "error",
    -- TODO: close fugitive on pre_save
    pre_save_cmds = { "NvimTreeClose" },
    post_restore_cmds = { "NvimTreeFindFile" },
    auto_session_suppress_dirs = { "~/", "~/code", "~/Downloads", "/" },
}
