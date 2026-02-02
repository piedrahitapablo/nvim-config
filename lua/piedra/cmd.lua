-- prevent errors for having slow/fast fingers
vim.api.nvim_create_user_command("W", "w", {
    desc = "Also save",
})
vim.api.nvim_create_user_command("Q", "q", {
    desc = "Also quit",
})

local function uuid()
    local id, _ = vim.fn.system("uuidgen"):gsub("\n", "")
    return string.lower(id)
end

vim.api.nvim_create_user_command("Uuid", function()
    vim.api.nvim_put({ uuid() }, "c", true, true)
end, {
    desc = "Insert UUID at cursor",
})
