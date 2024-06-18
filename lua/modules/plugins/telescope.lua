return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
    },
    config = function()
      local function filenameFirst(_, path)
        local tail = vim.fs.basename(path)
        local parent = vim.fs.dirname(path)
        if parent == '.' then
          return tail
        end
        return string.format('%s\t\t%s', tail, parent)
      end

      require('telescope').setup {
        defaults = {
          vimgrep_arguments = {
            'rg',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
          },
          sorting_strategy = 'ascending',
          layout_strategy = 'vertical',
          path_display = { 'absolute' },
          file_ignore_patterns = { '.git/', '.cache', 'build/', '%.class', '%.pdf', '%.mkv', '%.mp3', '%.zip' },
          layout_config = {
            vertical = {
              prompt_position = 'top',
              width = 0.9,
            },
            preview_cutoff = 1,
          },
        },
        pickers = {
          git_status = { path_display = filenameFirst },
          find_files = { path_display = filenameFirst, theme = 'ivy' },
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            mappings = {
              i = {
                ['<C-o>'] = require('telescope.actions').delete_buffer + require('telescope.actions').move_to_top,
              },
              n = {
                ['<C-o>'] = require('telescope.actions').delete_buffer + require('telescope.actions').move_to_top,
              },
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'live_grep_args')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]find current [W]ord' })
      vim.keymap.set('n', '<leader>fg', "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader><tab>', builtin.git_status, { desc = '[F]ind by [G]it status' })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = '[F] Find existing buffers' })
      vim.keymap.set('n', '<leader>fo', function()
        builtin.find_files { cwd = '~/personal/notes/org/' }
      end, { desc = '[F] org file' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
