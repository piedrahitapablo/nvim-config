local treesitter_context = require("treesitter-context")

treesitter_context.setup({
    enable = false,
    max_lines = 0,
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 20,
    trim_scope = "outer",
    mode = "cursor",
    separator = nil,
    zindex = 20,
})

vim.keymap.set("n", "<leader>kts", "<cmd>TSContextToggle<cr>")
