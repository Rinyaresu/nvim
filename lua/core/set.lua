vim.g.mapleader = ' '

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.laststatus = 3
opt.mouse = 'a'

opt.ignorecase = true
opt.smartcase = true

opt.hlsearch = false
opt.incsearch = true
opt.wrap = false
opt.breakindent = true

opt.autoindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

opt.cursorline = true

opt.signcolumn = 'yes'

opt.smartindent = true
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
opt.undofile = true

opt.updatetime = 50

opt.colorcolumn = '80'

opt.termguicolors = true

opt.showmode = false

opt.clipboard = "unnamedplus"
