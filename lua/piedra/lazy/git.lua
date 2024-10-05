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

local function GitBranchName()
    local branch =
        vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
    if branch ~= "" then
        return branch
    else
        return nil
    end
end

return {
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", FugitiveStatus)
            vim.keymap.set("n", "<leader>gb", function()
                vim.cmd.Git("blame")
            end)

            vim.api.nvim_create_user_command(
                "Gfa",
                "G fetch --all --prune --jobs=10",
                {
                    desc = "Git fetch all",
                    force = false,
                }
            )

            vim.api.nvim_create_user_command("Gco", function(opts)
                vim.cmd(string.format("G checkout %s", opts.fargs[1]))
            end, {
                desc = "Git checkout",
                force = false,
                nargs = 1,
            })

            vim.api.nvim_create_user_command("Gl", function(opts)
                vim.cmd.Git("pull")
            end, {
                desc = "Git push to upstream",
                force = false,
            })

            vim.api.nvim_create_user_command("Gp", function(opts)
                if opts.args == "" then
                    vim.cmd.Git("push")
                else
                    vim.cmd(string.format("G push %s", opts.fargs[1]))
                end
            end, {
                desc = "Git push to upstream",
                force = false,
                nargs = "?",
            })

            vim.api.nvim_create_user_command("Gpsup", function()
                local branch = GitBranchName()
                if branch == nil or branch == "" then
                    print("Could not get the name of the current branch")
                end

                vim.cmd.Git(
                    string.format("push --set-upstream origin %s", branch)
                )
            end, {
                desc = "Git push to upstream",
                force = false,
            })

            vim.api.nvim_create_user_command("Grreb", function(opts)
                vim.cmd.Gfa()
                vim.cmd.Git(string.format("rebase -i origin/%s", opts.fargs[1]))
            end, {
                desc = "Git rebase remote branch",
                force = false,
                nargs = 1,
                complete = function()
                    return { "develop" }
                end,
            })

            vim.api.nvim_create_user_command("Gc", function(opts)
                if opts.args == "" then
                    vim.cmd.Git("commit")
                else
                    vim.cmd.Git(string.format("commit %s", opts.fargs[1]))
                end
            end, {
                desc = "Git commit",
                force = false,
                nargs = "?",
            })
        end,
    },
    {
        "ruifm/gitlinker.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
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
            vim.keymap.set("n", "<leader>ghb", function()
                gitsigns.blame_line({ full = true })
            end)
        end,
    },
    {
        "akinsho/git-conflict.nvim",
        config = true,
    },
}
