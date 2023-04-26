local dired = require("dired")

dired.setup({
    path_separator = "/",
    show_banner = false,
    show_hidden = true,
    show_dot_dirs = true,
    show_colors = true,
})
