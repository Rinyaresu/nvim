vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true

vim.opt.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smarttab = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 50

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.swapfile = false

vim.opt.colorcolumn = '120'

vim.opt.wrap = true

vim.opt.termguicolors = true

vim.g.editorconfig = true
