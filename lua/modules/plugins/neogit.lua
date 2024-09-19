return {
  {
    'NeogitOrg/neogit',
    event = 'VeryLazy',
    dependencies = {
      'sindrets/diffview.nvim',
    },
    config = function()
      require('neogit').setup {
        commit_editor = {
          kind = 'split',
          show_staged_diff = true,
          staged_diff_split_kind = 'split',
        },
        integrations = {
          diffview = true,
          fzf_lua = true,
        },
        preview_buffer = {
          kind = 'split',
        },
      }

      vim.keymap.set('n', '<leader>g', '<cmd>Neogit<CR>')
      vim.api.nvim_create_autocmd('BufWinEnter', {
        pattern = 'Neogit*',
        callback = function()
          local timer = vim.loop.new_timer()
          timer:start(
            100,
            0,
            vim.schedule_wrap(function()
              if vim.fn.bufname():match '^Neogit' then
                vim.wo.wrap = true
                timer:close()
              end
            end)
          )
        end,
      })
    end,
  },
}
