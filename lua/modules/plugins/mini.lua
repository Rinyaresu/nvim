return {
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      require('mini.pairs').setup()
      require('mini.comment').setup()

      require('mini.files').setup {
        vim.keymap.set('n', '<leader>.', function()
          MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        end, { desc = 'Open file browser' }),

        mappings = {
          close = 'q',
          go_in = 'l',
          go_in_plus = '<CR>',
          go_out = 'h',
          go_out_plus = 'H',
          reset = '<BS>',
          reveal_cwd = '@',
          show_help = 'g?',
          synchronize = '=',
          trim_left = '<',
          trim_right = '>',
        },
      }

      require('mini.indentscope').setup {
        symbol = '│',
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
