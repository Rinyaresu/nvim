return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },

      vim.keymap.set('n', '<leader>bl', '<Cmd>Gitsigns blame_line<CR>'),
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
