return {
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup {
        notify_on_error = true,
        log_level = vim.log.levels.ERROR,
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 5000, lsp_fallback = true }
        end,
        formatters_by_ft = {
          lua = { 'stylua' },
          ruby = { 'rubocop' },
          javascript = { { 'prettier', 'eslint' } },
          javascriptreact = { { 'prettier', 'eslint' } },
          eruby = { 'htmlbeautifier' },
          markdown = { 'markdownlint' },
        },
      }
    end,

    vim.api.nvim_create_user_command('Format', function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ['end'] = { args.line2, end_line:len() },
        }
      end
      require('conform').format { async = true, lsp_fallback = true, range = range }
    end, { range = true }),

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    }),
    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    }),
  },

  vim.keymap.set('n', '<leader>F', '<Cmd>Format<CR>'),
}
-- vim: ts=2 sts=2 sw=2 et
