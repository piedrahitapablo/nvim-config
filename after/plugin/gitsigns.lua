local gitsigns = require("gitsigns")

gitsigns.setup({
    signcolumn = true,
    numhl = true,
})

vim.keymap.set("n", "<leader>ghp", gitsigns.preview_hunk_inline)
vim.keymap.set("n", "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>")
vim.keymap.set("v", "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>")
vim.keymap.set("n", "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>")
vim.keymap.set("v", "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>")
vim.keymap.set("n", "<leader>ghu", gitsigns.undo_stage_hunk)
vim.keymap.set("v", "<leader>ghu", gitsigns.undo_stage_hunk)
