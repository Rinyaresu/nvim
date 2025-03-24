local conf = require 'modules.editor.config'

packadd {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufRead', 'BufNewFile' },
  build = ':TSUpdate',
  config = conf.nvim_treesitter,
}

packadd {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  config = conf.snacks,
}

packadd {
  'echasnovski/mini.nvim',
  config = conf.mini,
}

packadd {
  'brenoprata10/nvim-highlight-colors',
  lazy = true,
  event = 'VeryLazy',
  opts = {
    render = 'background',
    enable_named_colors = true,
    enable_tailwind = true,
  },
}
