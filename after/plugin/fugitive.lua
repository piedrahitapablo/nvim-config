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

vim.keymap.set("n", "<leader>gs", FugitiveStatus)
