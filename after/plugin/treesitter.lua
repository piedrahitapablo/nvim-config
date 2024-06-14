local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
    ensure_installed = {
        "tsx",
        "toml",
        "json",
        "yaml",
        -- "swift",
        "css",
        "html",
        "lua",
        "vim",
        "c",
        -- "help",
        "rust",
        -- needed to highlight TODOs and FIXMEs
        "comment",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
        disable = {},
    },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

vim.treesitter.language.register("terraform", "terraform-vars")
