local M = {}

function M.rosepine()
  require('rose-pine').setup {
    styles = {
      bold = true,
      italic = false,
      transparency = false,
    },

    highlight_groups = {
      ['@comment'] = { italic = true },
      ['@function'] = { bold = true },
      ['@keyword'] = { italic = true, bold = true },
      ['@operator'] = { bold = true },
      ['@boolean'] = { bold = true, italic = true },
    },
  }
end

function M.incline()
  local colors = {
    background = '#faf4ed',
    foreground = '#464261',
    cursor = '#b4637a',
    black = '#f2e9e1',
    red = '#b4637a',
    green = '#286983',
    yellow = '#ea9d34',
    blue = '#56949f',
    magenta = '#907aa9',
    cyan = '#d7827e',
    white = '#464261',
    bright_black = '#797593',
    bright_white = '#464261',
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
        local branch_name = vim.fn.system 'git symbolic-ref --quiet --short HEAD'
        local exit_code = vim.v.shell_error

        if exit_code == 0 and branch_name ~= '' then
          local branch = branch_name:gsub('%s*$', '')
          if branch ~= '' then
            return { { ' ', guifg = colors.red }, { branch, guifg = colors.red } }
          end
        else
          local branch_name = vim.fn.system 'git rev-parse --abbrev-ref HEAD'
          local exit_code = vim.v.shell_error

          if exit_code == 0 and branch_name ~= '' then
            local branch = branch_name:gsub('%s*$', '')

            if branch ~= '' and branch ~= 'HEAD' then
              return { { ' ', guifg = colors.red }, { branch, guifg = colors.red } }
            elseif branch == 'HEAD' then
              local commit_hash = vim.fn.system 'git rev-parse --short HEAD'

              if vim.v.shell_error == 0 and commit_hash ~= '' then
                local hash = commit_hash:gsub('%s*$', '')

                return { { ' ', guifg = colors.red }, { hash, guifg = colors.red } }
              end
            end
          end
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
end

return M
