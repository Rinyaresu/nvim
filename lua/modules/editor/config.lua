local M = {}
local api = vim.api

function M.nvim_treesitter()
  require('nvim-treesitter.configs').setup {
    auto_install = true,
    ensure_installed = {
      'ruby',
      'bash',
      'rust',
      'lua',
      'python',
      'typescript',
      'javascript',
      'tsx',
      'css',
      'scss',
      'diff',
      'dockerfile',
      'graphql',
      'html',
      'sql',
      'markdown',
      'markdown_inline',
      'json',
      'jsonc',
      'vimdoc',
      'vim',
      'cmake',
    },

    highlight = {
      enable = true,
      disable = function(_, buf)
        local bufname = api.nvim_buf_get_name(buf)
        local max_filesize = 300 * 1024
        local ok, stats = pcall(vim.uv.fs_stat, bufname)
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
  }

  -- api.nvim_create_autocmd('FileType', {
  --   callback = function(args)
  --     local ok = pcall(vim.treesitter.get_parser, args.buf)
  --     if ok and vim.wo.foldmethod ~= 'expr' then
  --       vim.wo.foldmethod = 'expr'
  --       vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  --       vim.defer_fn(function()
  --         vim.cmd 'normal! zx'
  --       end, 50)
  --     end
  --   end,
  -- })
end

function M.snacks()
  local snacks = require 'snacks'
  snacks.setup {
    picker = { enabled = true },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
  }

  _G.Snacks = snacks
end

function M.mini()
  require('mini.pairs').setup()
  require('mini.comment').setup()
  require('mini.indentscope').setup {}

  require('mini.files').setup {
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
  _G.MiniFiles = require 'mini.files'
end

return M
