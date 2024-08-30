local ff = require('helpers').find_in_folder

return {
  {
    vim.filetype.add {
      extension = {
        coffee = 'javascript',
      },
    },

    vim.keymap.set('n', '<leader>rc', function()
      ff('app/controllers', 'Find controller')()
    end),

    vim.keymap.set('n', '<leader>rm', function()
      ff('app/models', 'Find model')()
    end),

    vim.keymap.set('n', '<leader>rs', function()
      ff('spec/', 'Find specs')()
    end),

    vim.keymap.set('n', '<leader>js', function()
      ff('app/javascript', 'Find JS files')()
    end),
  },
}
