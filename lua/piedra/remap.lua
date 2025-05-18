-- make home key go to the first non-empty char
vim.keymap.set("n", "<Home>", "^")
vim.keymap.set("v", "<Home>", "^")
vim.keymap.set("i", "<Home>", "<C-o>^")

-- remap meta+arrow to move words
vim.keymap.set("n", "<M-b>", "b")
vim.keymap.set("v", "<M-b>", "b")
vim.keymap.set("i", "<M-b>", "<C-o>b")
vim.keymap.set("n", "<M-f>", "w")
vim.keymap.set("v", "<M-f>", "w")
vim.keymap.set("i", "<M-f>", "<C-o>w")

-- delete words
vim.keymap.set("i", "<M-Del>", "<C-o>dw")
vim.keymap.set("i", "<M-BS>", "<C-o>db")

-- just to be able to swap selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor centered while moving half pages
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<PageDown>", "<PageDown>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<PageUp>", "<PageUp>zz")

-- keep cursor centered while searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste while keeping the same text in the registry
vim.keymap.set("x", "<leader>p", [["_dP]])

-- yank into system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- delete to void
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- * but stay in the current position
-- if problematic use the solution in https://superuser.com/a/299693
vim.keymap.set("n", "*", "*N")

-- same as *
vim.keymap.set("n", "<leader>ss", [[/\<<C-r><C-w>\>]])
vim.keymap.set("v", "<leader>ss", [[/\<<C-r><C-w>\>]])

-- replace word under cursor
vim.keymap.set(
    "n",
    "<leader>sr",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
)
-- replace selection (it's broken for strings that include escape sequences)
-- the "y" at the start is for yanking the selection and then paste it using <C-r>"
vim.keymap.set("v", "<leader>sr", 'y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>')
-- replace word under cursor with confirmation starting from the current line
vim.keymap.set(
    "n",
    "<leader>sc",
    [[:,$s/\<<C-r><C-w>\>/<C-r><C-w>/gIc|1,''-&&<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]]
)
-- replace selection with confirmation starting from the current line (it's broken for strings that include escape sequences)
vim.keymap.set(
    "v",
    "<leader>sc",
    "y:,$s/<C-r>\"/<C-r>\"/gIc|1,''-&&<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>"
)

-- toggle
vim.keymap.set("n", "<leader>kw", ":set wrap!<CR>")
vim.keymap.set("n", "<leader>ki", ":set smartindent!<CR>")
vim.keymap.set("n", "<leader>kr", ":set relativenumber!<CR>")

-- select pasted text
vim.keymap.set("n", "gp", "`[v`]")

-- close all buffers that are not visible
vim.keymap.set("n", "<leader>cab", function()
    -- Get all buffers
    local buffers = vim.api.nvim_list_bufs()

    -- Get visible buffers
    local visible_buffers = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        visible_buffers[buf] = true
    end

    -- Close non-visible buffers
    local closed_count = 0
    for _, buf in ipairs(buffers) do
        if
            not visible_buffers[buf]
            and vim.api.nvim_buf_is_valid(buf)
            and vim.api.nvim_get_option_value("buflisted", { buf = buf })
        then
            vim.api.nvim_buf_delete(buf, { force = false })
            closed_count = closed_count + 1
        end
    end

    -- Show how many buffers were closed
    vim.notify("Closed " .. closed_count .. " buffer(s)", vim.log.levels.INFO)
end)

-- buffer resize utils
vim.keymap.set(
    "n",
    "<leader>w80",
    ':lua vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.8))<CR>'
)

-- prevent errors for having slow/fast fingers
vim.api.nvim_create_user_command("W", "w", {
    desc = "Also save",
})
vim.api.nvim_create_user_command("Q", "q", {
    desc = "Also quit",
})
