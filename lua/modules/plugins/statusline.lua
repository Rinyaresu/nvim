return {
  {
    'custom-statusline',
    lazy = false,
    dir = vim.fn.stdpath 'config' .. '/lua/custom/statusline',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local statusline_colors = {
        background = '#F5F5F0',
        foreground = '#654735',
        git = '#D20F39',
        lsp = '#1E66F5',
      }

      local function get_git_branch()
        local git_dir = vim.fn.finddir('.git', '.;')
        if git_dir == '' then
          return ''
        end

        local head_file = io.open(git_dir .. '/HEAD', 'r')
        if not head_file then
          return ''
        end

        local content = head_file:read '*all'
        head_file:close()

        local branch = content:match 'ref: refs/heads/(.-)%s*$' or content:sub(1, 7)
        return branch ~= '' and ' ' .. branch or ''
      end

      local function get_lsps_formatters()
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local buf_clients = vim.lsp.get_clients()
        local server_names = {}
        local ignore_lsp_servers = {
          ['null-ls'] = true,
          ['copilot'] = true,
        }

        for _, client in pairs(buf_clients) do
          if not ignore_lsp_servers[client.name] then
            table.insert(server_names, client.name)
          end
        end

        if package.loaded['null-ls'] then
          local has_null_ls, null_ls = pcall(require, 'null-ls')
          if has_null_ls then
            local sources = require 'null-ls.sources'
            local available_sources = sources.get_available(buf_ft)
            for _, source in ipairs(available_sources) do
              table.insert(server_names, source.name)
            end
          end
        end

        if package.loaded['conform'] then
          local has_conform, conform = pcall(require, 'conform')
          if has_conform then
            local formatters = conform.list_formatters(0)
            for _, formatter in ipairs(formatters) do
              if formatter and formatter.name then
                table.insert(server_names, formatter.name)
              end
            end
          end
        end

        server_names = vim.fn.uniq(server_names)
        table.sort(server_names)

        return #server_names > 0 and table.concat(server_names, ', ') or 'NO LSP/FORMATTER'
      end

      local function status_line()
        local git_branch = get_git_branch()
        local lsps_formatters = get_lsps_formatters()
        local total_width = vim.o.columns
        local lsp_width = #lsps_formatters
        local git_width = #git_branch
        local center_offset = 2

        local lsp_left_padding = math.floor((total_width - lsp_width) / 2) + center_offset
        local lsp_right_padding = total_width - lsp_left_padding - lsp_width

        return table.concat {
          '%#StatusLineGit#',
          git_branch,
          '%#StatusLine#',
          string.rep(' ', lsp_left_padding - git_width),
          '%#StatusLineLsp#',
          lsps_formatters,
          '%#StatusLine#',
          string.rep(' ', lsp_right_padding),
        }
      end

      vim.cmd(
        string.format(
          [[
        hi StatusLine guibg=%s guifg=%s
        hi StatusLineGit guibg=%s guifg=%s gui=bold
        hi StatusLineLsp guibg=%s guifg=%s
      ]],
          statusline_colors.background,
          statusline_colors.background,
          statusline_colors.background,
          statusline_colors.git,
          statusline_colors.background,
          statusline_colors.lsp
        )
      )

      vim.o.statusline = '%!v:lua.status_line()'
      _G.status_line = status_line

      vim.api.nvim_create_autocmd({ 'LspAttach', 'LspDetach', 'BufWritePost', 'BufEnter', 'VimResized' }, {
        callback = function()
          vim.cmd 'redrawstatus'
        end,
      })
    end,
  },
}
