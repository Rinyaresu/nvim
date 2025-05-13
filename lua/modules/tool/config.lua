local M = {}

function M.arrow()
  require('arrow').setup {
    separate_save_and_remove = true,
    show_icons = true,
    leader_key = ';',
    buffer_leader_key = 'm',
    separate_by_branch = true,
  }
end

function M.neogit()
  require('neogit').setup {
    commit_editor = {
      kind = 'split',
      show_staged_diff = true,
      staged_diff_split_kind = 'split',
    },
    integrations = {
      diffview = true,
      snacks = true,
    },
    preview_buffer = {
      kind = 'split',
    },
  }

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
end

return M
