local map = require 'core.keymap'
local cmd = map.cmd

-- Terminal mode
map.t {
  ['<Esc><Esc>'] = '<C-\\><C-n>',
}

-- Normal mode navigation
map.n {
  -- Basic movement
  ['j'] = 'gj',
  ['k'] = 'gk',

  -- Window movement
  ['<A-h>'] = '<C-w><C-h>',
  ['<A-l>'] = '<C-w><C-l>',
  ['<A-j>'] = '<C-w><C-j>',
  ['<A-k>'] = '<C-w><C-k>',

  -- Window resizing
  ['>>'] = '<C-w>>',
  ['<<'] = '<C-w><',

  -- Common operations
  ['<C-u>'] = '<C-u>zz',
  ['<C-d>'] = '<C-d>zz',
  ['<N>'] = 'Nzzzv',
  ['<n>'] = 'nzzzv',
  ['<Esc>'] = cmd 'nohlsearch',
  ['<A-q>'] = cmd 'bd',

  -- Macros and quickfix
  ['M'] = cmd 'norm! gn@q',
}

-- Visual mode
map.v {
  ['J'] = ":m '>+1<CR>gv=gv",
  ['K'] = ":m '<-2<CR>gv=gv",
  ['gM'] = [[y<cmd>let @/=substitute(escape(@", '/'), '\n', '\\n', 'g')<cr>gvqq]],
}
