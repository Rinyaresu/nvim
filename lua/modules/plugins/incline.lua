return {
  {
    'b0o/incline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local colors = {
        background = '#F8F8F7',
        foreground = '#654735',
        cursor = '#DC8A78',
        black = '#5C5F77',
        red = '#D20F39',
        green = '#40A02B',
        yellow = '#DF8E1D',
        blue = '#1E66F5',
        magenta = '#EA76CB',
        cyan = '#179299',
        white = '#ACB0BE',
        bright_black = '#6C6F85',
        bright_white = '#BCC0CC',
      }

      require('incline').setup {
        window = {
          padding = 0,
          margin = { vertical = 0, horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          if filename == '' then
            filename = '[No Name]'
          end

          local function get_diagnostic_label()
            local icons = { error = ' ', warn = ' ', info = '  ', hint = ' ' }
            local label = {}
            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. n .. ' ', group = 'DiagnosticSign' .. severity })
              end
            end
            if #label > 0 then
              table.insert(label, { '| ' })
            end
            return label
          end

          local function get_git_branch_name()
            local git_dir = vim.fn.finddir('.git', '.;')
            if git_dir ~= '' then
              local head_file = io.open(git_dir .. '/HEAD', 'r')
              if head_file then
                local content = head_file:read '*all'
                head_file:close()

                local branch = content:match 'ref: refs/heads/(.-)%s*$' or content:sub(1, 7) or ''
                if branch ~= '' then
                  return { { ' ', guifg = colors.red }, { branch, guifg = colors.red } }
                end
              end
              return ''
            end
            return ''
          end

          return {
            { '', guifg = colors.background },
            {
              { get_diagnostic_label() },
              { get_git_branch_name() },
              guibg = colors.background,
              guifg = colors.foreground,
            },
            { '', guifg = colors.background },
          }
        end,
      }
    end,
    event = 'VeryLazy',
  },
}
