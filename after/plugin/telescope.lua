local builtin = require("telescope.builtin")
local session_lens = require("session-lens")
local telescope = require("telescope")

telescope.setup({
    defaults = {
        layout_config = {
            prompt_position = "top",
        },
        prompt_prefix = "> ",
        sorting_strategy = "ascending",
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
        },
        live_grep = {
            additional_args = function()
                return { "--hidden", "-g", "!.git" }
            end,
        },
        git_status = {
            git_icons = {
                added = "A",
                changed = "M",
                copied = "C",
                deleted = "D",
                renamed = "R",
                unmerged = "U",
                untracked = "?",
            },
        },
    },
})

vim.keymap.set("n", "<leader>tf", builtin.find_files, {})
vim.keymap.set("n", "<leader>ts", builtin.live_grep, {})
vim.keymap.set("n", "<leader>tb", builtin.buffers, {})
vim.keymap.set("n", "<leader>td", builtin.diagnostics, {})
vim.keymap.set("n", "<leader>tc", builtin.commands, {})
vim.keymap.set("n", "<leader>tr", builtin.resume, {})

vim.keymap.set("n", "<leader>tgf", builtin.git_files, {})
vim.keymap.set("n", "<leader>tgc", builtin.git_commits, {})
vim.keymap.set("n", "<leader>tgb", builtin.git_bcommits, {})
vim.keymap.set("n", "<leader>tgs", builtin.git_status, {})

session_lens.setup({})
telescope.load_extension("session-lens")

vim.keymap.set("n", "<leader>sl", session_lens.search_session)
