local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.mouse = 'a'

opt.hlsearch = true
opt.incsearch = true

opt.clipboard = 'unnamedplus'

opt.breakindent = true

opt.undofile = true
opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'

opt.ignorecase = true
opt.smartcase = true
opt.smarttab = true

opt.signcolumn = 'yes'

opt.updatetime = 50

opt.splitright = true
opt.splitbelow = true

opt.list = true
opt.listchars = {
  tab = '>>>',
  trail = '·',
  precedes = '←',
  extends = '→',
  eol = '↲',
  nbsp = '␣',
}

opt.inccommand = 'split'

opt.cursorline = true

opt.scrolloff = 10

opt.swapfile = false

opt.colorcolumn = '120'

opt.wrap = true

opt.termguicolors = true

opt.conceallevel = 2
opt.concealcursor = 'nc'
opt.laststatus = 3
