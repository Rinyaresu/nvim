vim.g.mapleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.laststatus = 3
vim.opt.mouse = 'a'

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.expandtab = false
vim.opt.signcolumn = 'yes'

vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.updatetime = 50

vim.opt.colorcolumn = '80'

vim.opt.termguicolors = true

vim.opt.showmode = false
