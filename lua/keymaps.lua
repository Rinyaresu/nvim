vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>oqq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Suckless
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '>>', '<C-w>>')
vim.keymap.set('n', '<<', '<C-w><')
vim.keymap.set('n', '<leader>a', '<Cmd>keepjumps normal! ggVG<CR>')
vim.keymap.set('n', '<leader>y', function()
  require('helpers').copy_path()
end)
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<N>', 'Nzzzv')
vim.keymap.set('n', '<n>', 'nzzzv')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>o', '<Cmd>setlocal spell! spelllang=pt<CR>')
vim.keymap.set('n', '<A-q>', '<Cmd>bd<CR>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<leader>rw', function()
  require('helpers').find_and_replace()
end)

-- Macros
vim.keymap.set('n', '<leader>qf', "<Cmd>cdo execute 'norm! @q' | update<CR>")

vim.keymap.set('v', 'gM', [[y<cmd>let @/=substitute(escape(@", '/'), '\n', '\\n', 'g')<cr>gvqq]])
vim.keymap.set('n', 'M', '<Cmd>norm! gn@q<CR>')

vim.keymap.set('n', '<leader>oq', '<Cmd>copen<CR>')
vim.keymap.set('n', '<leader>rq', function()
  require('helpers').replace_in_quickfix()
end)
-- vim: ts=2 sts=2 sw=2 et
