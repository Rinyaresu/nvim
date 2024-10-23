return {
  {
    'otavioschwanck/arrow.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    opts = {
      separate_save_and_remove = true,
      show_icons = true,
      leader_key = ';',
      buffer_leader_key = 'm',
      separate_by_branch = true,
    },

    vim.keymap.set('n', '<C-A-k>', '<cmd>Arrow next_buffer_bookmark<CR>', { silent = true }),

    vim.keymap.set('n', '<C-A-j>', '<cmd>Arrow prev_buffer_bookmark<CR>', { silent = true }),

    vim.keymap.set('n', '<C-f>', function()
      require('arrow.persist').toggle()
    end),
  },
}
-- vim: ts=2 sts=2 sw=2 et
