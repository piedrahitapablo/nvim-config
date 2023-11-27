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
            layout_config = {
                preview_width = 0.6,
            },
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
    extensions = {
        undo = {
            layout_config = {
                preview_width = 0.7,
            },
        },
        recent_files = {
            only_cwd = true,
            layout_config = {
                preview_width = 0.6,
            },
        },
    },
})

vim.keymap.set("n", "<leader>tf", builtin.find_files, {})
vim.keymap.set("n", "<leader>ts", builtin.live_grep, {})
vim.keymap.set("n", "<leader>ty", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>tb", builtin.buffers, {})
vim.keymap.set("n", "<leader>td", builtin.diagnostics, {})
vim.keymap.set("n", "<leader>tc", builtin.commands, {})
vim.keymap.set("n", "<leader>tr", builtin.resume, {})
vim.keymap.set("n", "<leader>tq", builtin.quickfix, {})

vim.keymap.set("n", "<leader>tgf", builtin.git_files, {})
vim.keymap.set("n", "<leader>tgc", builtin.git_commits, {})
vim.keymap.set("n", "<leader>tgb", builtin.git_bcommits, {})
vim.keymap.set("n", "<leader>tgs", builtin.git_status, {})

session_lens.setup({})
telescope.load_extension("session-lens")

vim.keymap.set("n", "<leader>sl", session_lens.search_session)

telescope.load_extension("undo")
vim.keymap.set("n", "<leader>u", telescope.extensions.undo.undo)

telescope.load_extension("recent_files")
vim.keymap.set("n", "<leader><leader>", telescope.extensions.recent_files.pick)
