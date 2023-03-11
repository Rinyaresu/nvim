vim.g.mapleader = ' '

-- Shortcuts
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>h', '^')
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>l', 'g_')
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Basic clipboard interaction
vim.keymap.set({ 'n', 'x' }, 'y', '"+y')
vim.keymap.set({ 'n', 'x' }, 'p', '"+p')

-- Delete text
vim.keymap.set({ 'n', 'x' }, 'x', '"_x')

-- Commands
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
vim.keymap.set('n', '<leader>bq', '<cmd>bdelete<cr>')
vim.keymap.set('n', '<leader>bl', '<cmd>buffer #<cr>')

vim.keymap.set('n', 'H', '<cmd>BufferLineCyclePrev<cr><CR>')
vim.keymap.set('n', 'L', '<cmd>BufferLineCycleNext<CR>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


vim.keymap.set('n', '<leader>fu', ":UndotreeToggle<CR> <BAR> :UndotreeFocus<CR>")

vim.keymap.set('n', '<leader>mp', ':MindOpenMain<CR>')
vim.keymap.set('n', '<leader>mc', ':MindClose<CR>')

vim.keymap.set('n', '<leader>bc', '<cmd>Bdelete<CR>')

vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<CR>')
vim.keymap.set('n', '<leader><tab>', '<cmd>Telescope git_status<CR>')

vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})
vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})

vim.keymap.set('n', '<leader>gg', '<cmd>:LazyGit<CR>')
