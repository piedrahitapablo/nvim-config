function Prettier()
    local FilePath = vim.api.nvim_buf_get_name(0)

    vim.fn.system({
        "prettier",
        "--write",
        "--prose-wrap",
        "always",
        "--print-width",
        "80",
        FilePath,
    })
    vim.cmd("e!")
end

-- TODO: find a way to make this work
-- vim.api.nvim_create_user_command("Prettier", "lua Prettier")
