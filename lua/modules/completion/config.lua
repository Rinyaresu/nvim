local M = {}
local au = vim.api.nvim_create_user_command

function M.blink()
  require('blink.cmp').setup {
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    signature = { enabled = true },
    appearance = {
      nerd_font_variant = 'mono',
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    completion = {
      menu = {
        draw = {
          -- We don't need label_description now because label and label_description are already
          -- combined together in label by colorful-menu.nvim.
          columns = { { 'kind_icon' }, { 'label', gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
    },
  }
end

function M.conform()
  local sql_formatter_config_file = os.getenv 'HOME' .. '/.config/sql_formatter/sql_formatter.json'

  require('conform').setup {
    notify_on_error = true,
    log_level = vim.log.levels.ERROR,

    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 5000, lsp_fallback = true }
    end,

    formatters = {
      sql_formatter = {
        args = {
          '-l',
          'plsql',
          '--config',
          sql_formatter_config_file,
        },
      },
    },

    formatters_by_ft = {
      lua = { 'stylua' },
      ruby = { 'rubocop' },
      javascript = { 'prettier', 'eslint' },
      javascriptreact = { 'prettier', 'eslint' },
      eruby = { 'htmlbeautifier' },
      astro = { 'prettier' },
      markdown = { 'prettier' },
      css = { 'prettier' },
      html = { 'prettier' },
    },
  }

  au('Format', function(args)
    local range = nil
    if args.count ~= -1 then
      local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
      range = {
        start = { args.line1, 0 },
        ['end'] = { args.line2, end_line:len() },
      }
    end
    require('conform').format { async = true, lsp_fallback = true, range = range }
  end, { range = true })

  au('FormatDisable', function(args)
    if args.bang then
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
  end, {
    desc = 'Disable autoformat-on-save',
    bang = true,
  })

  au('FormatEnable', function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
  end, {
    desc = 'Re-enable autoformat-on-save',
  })
end

return M
