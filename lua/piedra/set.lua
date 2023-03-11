-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = false

-- show indentation and blank lines
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "trail:⋅"
-- vim.opt.listchars:append "eol:↴"

-- tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- text wrapping
vim.opt.wrap = false

-- code folding
vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = -1
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- title
vim.opt.title = true
-- uncomment to set a custom title, this is not the default but it's very
-- similar
-- https://github.com/neovim/neovim/issues/1248#issuecomment-1185487263
-- vim.opt.titlestring = '%t%(\ %M%)%(\ \(%{expand(\"%:~:h\")}\)%)%a\ -\ NVIM'

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- splits
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
