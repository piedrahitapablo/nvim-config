return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    layout_config = {
                        prompt_position = "top",
                        width = {
                            0.9,
                            min = 250,
                        },
                        height = {
                            0.8,
                            min = 70,
                        },
                    },
                    prompt_prefix = "> ",
                    sorting_strategy = "ascending",
                },
                pickers = {
                    find_files = {
                        find_command = {
                            "rg",
                            "--files",
                            "--hidden",
                            "-g",
                            "!.git",
                        },
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

            local telescope_builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>tf", telescope_builtin.find_files, {})
            vim.keymap.set("n", "<leader>ts", telescope_builtin.live_grep, {})
            vim.keymap.set("n", "<leader>ty", function()
                telescope_builtin.grep_string({
                    search = vim.fn.input("Grep > "),
                })
            end)
            vim.keymap.set(
                "n",
                "<leader>t/",
                telescope_builtin.current_buffer_fuzzy_find,
                {}
            )
            vim.keymap.set("n", "<leader>tb", telescope_builtin.buffers, {})
            vim.keymap.set("n", "<leader>td", telescope_builtin.diagnostics, {})
            vim.keymap.set("n", "<leader>tc", telescope_builtin.commands, {})
            vim.keymap.set("n", "<leader>tr", telescope_builtin.resume, {})
            vim.keymap.set("n", "<leader>tq", telescope_builtin.quickfix, {})

            vim.keymap.set("n", "<leader>tgf", telescope_builtin.git_files, {})
            vim.keymap.set(
                "n",
                "<leader>tgc",
                telescope_builtin.git_commits,
                {}
            )
            vim.keymap.set(
                "n",
                "<leader>tgb",
                telescope_builtin.git_bcommits,
                {}
            )
            vim.keymap.set("n", "<leader>tgs", telescope_builtin.git_status, {})
        end,
    },
    {
        "smartpde/telescope-recent-files",
        config = function()
            local telescope = require("telescope")
            telescope.load_extension("recent_files")
            vim.keymap.set(
                "n",
                "<leader><leader>",
                telescope.extensions.recent_files.pick
            )
        end,
    },
    {
        "debugloop/telescope-undo.nvim",
        config = function()
            local telescope = require("telescope")
            telescope.load_extension("undo")
            vim.keymap.set("n", "<leader>u", telescope.extensions.undo.undo)
        end,
    },
    {
        "rmagatti/session-lens",
        dependencies = {
            "rmagatti/auto-session",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local session_lens = require("session-lens")
            session_lens.setup({})

            local telescope = require("telescope")
            telescope.load_extension("session-lens")

            vim.keymap.set("n", "<leader>sl", session_lens.search_session)
        end,
    },
}
