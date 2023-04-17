local status, tree = pcall(require, "nvim-tree")
if (not status) then
    print("nvim-tree is not installed")
    return
end

local status, api = pcall(require, "nvim-tree.api")
if not status then
    print("nvim-tree.api is not installed")
    return
end

tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    view = {
        side = 'left',
        number = true,
        relativenumber = true,
        width = 30,
        hide_root_folder = true,
    },
    renderer = {
        indent_width = 1,
        indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
                corner = "",
                edge = "│",
                item = "",
                bottom = "─",
                none = " ",
            },
        },
        icons = {
            git_placement = "after",
            show = {
                folder_arrow = false,
            },
            glyphs = {
                folder = {
                    default = "",
                    open = "",
                },
            },
        },
    },
    git = {
        ignore = false,
    },
    filters = {
        dotfiles = false,
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    modified = {
        enable = true,
    }
}

api.events.subscribe(api.events.Event.FileCreated, function(file)
    vim.cmd("edit " .. file.fname)
end)

vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeFindFile)
vim.keymap.set("n", "<leader>pb", vim.cmd.NvimTreeFindFileToggle)
