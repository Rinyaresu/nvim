require 'keymap.remap'
local map = require 'core.keymap'
local cmd = map.cmd

map.n {
  -- Lspsaga
  ['[d'] = cmd 'Lspsaga diagnostic_jump_next',
  [']d'] = cmd 'Lspsaga diagnostic_jump_prev',
  ['K'] = cmd 'Lspsaga hover_doc',
  ['ga'] = cmd 'Lspsaga code_action',
  ['gr'] = cmd 'Lspsaga rename',
  ['gd'] = cmd 'Lspsaga peek_definition',
  ['gp'] = cmd 'Lspsaga goto_definition',
  ['gh'] = cmd 'Lspsaga finder',
  ['<Leader>ot'] = cmd 'Lspsaga outline',

  -- Picker
  ['<leader>ff'] = function()
    Snacks.picker.files()
  end,
  ['<leader>fg'] = function()
    Snacks.picker.grep()
  end,
  ['<leader><tab>'] = function()
    Snacks.picker.git_status()
  end,
  ['<leader>fr'] = function()
    Snacks.picker.recent()
  end,
  ['<leader>gd'] = function()
    Snacks.picker.lsp_definitions()
  end,
  ['<leader>gD'] = function()
    Snacks.picker.lsp_declarations()
  end,

  -- Explorer
  ['<leader>.'] = function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
  end,

  -- Bookmarks
  ['<C-f>'] = function()
    require('arrow.persist').toggle()
  end,
  ['<C-A-k>'] = cmd 'Arrow next_buffer_bookmark',
  ['<C-A-j>'] = cmd 'Arrow prev_buffer_bookmark',

  -- UndoTree
  ['<leader>u'] = cmd 'UndotreeToggle | UndotreeFocus',

  -- Git
  ['<leader>g'] = cmd 'Neogit kind=replace',
  ['<leader>bl'] = cmd 'Gitsigns blame_line',

  -- Formatter
  ['<leader>F'] = cmd 'Format',

  -- Runs API requests
  ['<leader>rr'] = cmd 'Rest run',

  -- Selection and utilities
  ['<leader>a'] = cmd 'keepjumps normal! ggVG',
  ['<leader>o'] = cmd 'setlocal spell! spelllang=pt',

  -- Diagnostics
  ['<leader>e'] = vim.diagnostic.open_float,
  ['<leader>oqq'] = vim.diagnostic.setloclist,

  -- Quickfix related
  ['<leader>qf'] = cmd "cdo execute 'norm! @q' | update",
  ['<leader>oq'] = cmd 'copen',
  ['<leader>rq'] = function()
    require('internal.helpers').replace_in_quickfix()
  end,

  -- Path and search helpers
  ['<leader>y'] = function()
    require('internal.helpers').copy_path()
  end,
  ['<leader>rw'] = function()
    require('internal.helpers').find_and_replace()
  end,

  -- Debugger
  ['<leader>d'] = function()
    require('internal.helpers').add_debugger()
  end,

  ['<leader>D'] = function()
    require('internal.helpers').clear_debugger()
  end,
}

map.nx('ga', cmd 'Lspsaga code_action')
