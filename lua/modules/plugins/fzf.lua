return {
  {
    'ibhagwan/fzf-lua',
    config = function()
      local fzf = require 'fzf-lua'
      require('fzf-lua').setup {
        defaults = {
          formatter = 'path.filename_first',
          keymap = {
            fzf = {
              ['ctrl-u'] = 'half-page-up',
              ['ctrl-d'] = 'half-page-down',
            },
          },
        },

        winopts = {
          split = 'belowright new',
          -- fullscreen = true,
          relativenumber = true,
          foldenable = true,
          preview = {
            default = 'bat',
            wrap = 'wrap',
            horizontal = 'right:50%',
          },
        },
        grep = {
          rg_glob = true,
        },
        previewers = {
          git_diff = {
            pager = 'delta --line-numbers --light',
          },
        },
      }

      require('fzf-lua').register_ui_select()
      vim.keymap.set('n', '<leader>ff', fzf.files)
      vim.keymap.set('n', '<leader>b', fzf.buffers)
      vim.keymap.set('n', '<leader>fg', fzf.live_grep_glob)
      vim.keymap.set('n', '<leader>fr', fzf.oldfiles)
      vim.keymap.set('n', '<leader><tab>', fzf.git_status)
      vim.keymap.set('n', '<leader>fo', function()
        fzf.files { cwd = '~/personal/notes/org/' }
      end)
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
