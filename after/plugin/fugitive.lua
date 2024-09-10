local function FugitiveStatus()
    if vim.api.nvim_buf_get_name(0):find("^fugitive:///") then
        -- if fugitive is the current buffer, close it
        vim.cmd([[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]])
    elseif vim.fn.buflisted(vim.fn.bufname("fugitive:///*/.git//$")) ~= 0 then
        -- if fugitive is opened but it's not the current buffer, focus it
        vim.cmd([[tab Git]])
    else
        -- if fugitive is closed, open it
        vim.cmd([[tab Git]])
    end
end

local function GitBranchName()
    local branch =
        vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
    if branch ~= "" then
        return branch
    else
        return nil
    end
end

vim.keymap.set("n", "<leader>gs", FugitiveStatus)

vim.api.nvim_create_user_command("Gfa", "G fetch --all --prune --jobs=10", {
    desc = "Git fetch all",
    force = false,
})
vim.api.nvim_create_user_command("Gp", function(opts)
    if opts.args == "" then
        vim.cmd("G push")
    else
        vim.cmd(string.format("G push %s", opts.fargs[1]))
    end
end, {
    desc = "Git push to upstream",
    force = false,
    nargs = "?",
})
vim.api.nvim_create_user_command("Gpsup", function()
    local branch = GitBranchName()
    if branch == nil or branch == "" then
        print("Could not get the name of the current branch")
    end

    vim.cmd(string.format("G push --set-upstream origin %s", branch))
end, {
    desc = "Git push to upstream",
    force = false,
})
vim.api.nvim_create_user_command("Grreb", function(opts)
    vim.cmd.Gfa()
    vim.cmd(string.format("G rebase -i origin/%s", opts.fargs[1]))
end, {
    desc = "Git rebase remote branch",
    force = false,
    nargs = 1,
    complete = function()
        return { "develop" }
    end,
})
vim.api.nvim_create_user_command("Gc", function(opts)
    vim.cmd(string.format("G commit %s", opts.fargs[1]))
end, {
    desc = "Git commit",
    force = false,
    nargs = 1,
})
