vim.g.mapleader = ' '

local keymap = vim.keymap.set

-- Shortcuts
keymap({ 'n', 'x', 'o' }, '<leader>h', '^')
keymap({ 'n', 'x', 'o' }, '<leader>l', 'g_')
keymap('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Basic clipboard interaction
keymap({ 'n', 'x' }, 'y', '"+y')
keymap({ 'n', 'x' }, 'p', '"+p')
keymap({ 'n', 'x' }, '<leader>fy', '<cmd>:call CopyFullPath()<CR>')

-- Delete text
keymap({ 'n', 'x' }, 'x', '"_x')

-- Delete line
keymap({ 'n', 'x' }, 'd', '"+d')

-- Buffer
keymap('n', '<leader>w', '<cmd>write<cr>')
keymap('n', '<leader>bc', '<cmd>Bdelete<CR>')
keymap('n', '<leader>bq', '<cmd>bdelete<cr>')
keymap('n', '<leader>bl', '<cmd>buffer #<cr>')
keymap('n', 'H', '<cmd>BufferLineCyclePrev<cr><CR>')
keymap('n', 'L', '<cmd>BufferLineCycleNext<CR>')

-- Move lines up and down
keymap('v', 'K', ":m '<-2<CR>gv=gv")
keymap('v', 'J', ":m '>+1<CR>gv=gv")

-- Motions
keymap('n', 'J', 'mzJ`z')
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')
keymap('n', 'n', 'nzzzv')
keymap('n', 'N', 'Nzzzv')

-- Replace word
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Undo tree
keymap('n', '<leader>fu', ":UndotreeToggle<CR> <BAR> :UndotreeFocus<CR>")

-- Mind
keymap('n', '<leader>mp', ':MindOpenMain<CR>')
keymap('n', '<leader>mc', ':MindClose<CR>')

-- Telescope
keymap('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
keymap('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
keymap('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
keymap('n', '<leader>fr', '<cmd>Telescope oldfiles<CR>')
keymap('n', '<leader><tab>', '<cmd>Telescope git_status<CR>')
keymap('n', '<leader>fb', '<cmd>Telescope lsp_document_symbols<CR>')

-- Persistence sessions
vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})
vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})

-- Git
keymap('n', '<leader>gg', '<cmd>:LazyGit<CR>')
keymap('n', '<leader>gd', '<cmd>:DiffviewOpen<CR>')
keymap('n', '<leader>gl', '<cmd>:DiffviewFileHistory<CR>')
keymap('n', '<leader>gc', '<cmd>:DiffviewClose<CR>')

-- Ruby
keymap("n", "<Leader>rc", ":lua require('ror.commands').list_commands()<CR>", { silent = true })


-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

-- Code action
keymap({ "n", "v" }, "<leader>ga", "<cmd>Lspsaga code_action<CR>")

-- Rename all occurrences of the hovered word for the entire file
keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

-- Rename all occurrences of the hovered word for the selected files
keymap("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")

-- Go to definition
keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

-- Peek type definition
-- You can edit the file containing the type definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

-- Go to type definition

-- Show line diagnostics
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window
keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

-- Show cursor diagnostics
-- Like show_line_diagnostics, it supports passing the ++unfocus argument
keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

-- Show buffer diagnostics
keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Diagnostic jump with filters such as only jumping to an error
keymap("n", "[E", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
keymap("n", "]E", function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

-- Toggle outline
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

-- Hover Doc
-- If there is no hover doc,
-- there will be a notification stating that
-- there is no information available.
-- To disable it just use ":Lspsaga hover_doc ++quiet"
-- Pressing the key twice will enter the hover window
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

-- If you want to keep the hover window in the top right hand corner,
-- you can pass the ++keep argument
-- Note that if you use hover with ++keep, pressing this key again will
-- close the hover window. If you want to jump to the hover window
-- you should use the wincmd command "<C-w>w"
keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

-- Call hierarchy
keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

-- Floating terminal
keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
