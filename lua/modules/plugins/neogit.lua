return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'sindrets/diffview.nvim',
    },
    config = function()
      require('neogit').setup {
        commit_editor = {
          kind = 'split',
        },
      }

      vim.keymap.set('n', '<leader>g', '<cmd>Neogit<CR>')
    end,
  },
}
