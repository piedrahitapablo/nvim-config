local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- very important, this needs to be set before the plugins are required
vim.g.mapleader = " "

local lazy = require("lazy")
lazy.setup({
    spec = "piedra.lazy",
    change_detection = {
        notify = false,
    },
    checker = {
        enabled = true,
        check_pinned = true,
    },
})

-- lazy.setup({
--     -- previews
--     {
--         "iamcco/markdown-preview.nvim",
--         commit = "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee",
--         cmd = {
--             "MarkdownPreviewToggle",
--             "MarkdownPreview",
--             "MarkdownPreviewStop",
--         },
--         ft = { "markdown" },
--         build = function()
--             vim.fn["mkdp#util#install"]()
--         end,
--     },
-- })
