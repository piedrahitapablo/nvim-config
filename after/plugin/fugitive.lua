local function ShowFugitive()
    vim.cmd([[
        vertical Git
        wincmd L
        vertical resize 70
        setlocal winfixwidth
    ]])
end

-- TODO: make this a toggle
local function FugitiveStatus()
    if vim.fn.buflisted(vim.fn.bufname("fugitive:///*/.git//$")) ~= 0 then
        vim.cmd([[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]])
    else
        ShowFugitive()
    end
end

vim.keymap.set("n", "<leader>gs", FugitiveStatus)
