return {
  {
    'b0o/incline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local colors = {
        background = '#1F1F28',
        foreground = '#DCD7BA',
        cursor = '#E46876',
        black = '#16161D',
        red = '#E82424',
        green = '#76946A',
        yellow = '#DCA561',
        blue = '#7E9CD8',
        magenta = '#957FB8',
        cyan = '#7AA89F',
        white = '#C8C093',
        bright_black = '#54546D',
        bright_white = '#C5C9C5',
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
            { '', guibg = colors.background, guifg = colors.background },
            {
              { get_diagnostic_label() },
              { get_git_branch_name() },
              guibg = colors.background,
              guifg = colors.black,
            },
            { '', guibg = colors.background, guifg = colors.background },
          }
        end,
      }
    end,
    event = 'VeryLazy',
  },
}
