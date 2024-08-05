vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

function Prettier()
    local FilePath = vim.api.nvim_buf_get_name(0)

    vim.fn.system({ "yarn", "prettier", "--write", FilePath })
    vim.cmd("e!")
end

-- TODO: find a way to make this work
-- vim.api.nvim_create_user_command("Prettier", "lua Prettier")
