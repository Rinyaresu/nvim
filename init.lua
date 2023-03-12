require('core.set')
require('core.remap')
require('core.lazy')
require('core.autocmds')
require('core.plugins')
require('helper.vim-function')

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})
