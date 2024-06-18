return {
  {
    vim.keymap.set('n', '<leader>d', function()
      require('helpers').add_debugger()
    end),

    vim.keymap.set('n', '<leader>D', function()
      require('helpers').clear_debugger()
    end),
  },
}
