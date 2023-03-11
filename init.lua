require('core.set')
require('core.remap')
require('core.lazy')
require('core.autocmds')
require('core.plugins')

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})
