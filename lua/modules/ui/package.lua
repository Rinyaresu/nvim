local conf = require 'modules.ui.config'

packadd {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000,
  config = conf.rosepine,
}

packadd {
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  config = conf.catppuccin,
}

packadd {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = true },
}

packadd {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown', 'codecompanion' },
  -- opts = {
  --
  --   code = {
  --     sign = false,
  --     width = 'block',
  --     right_pad = 1,
  --   },
  --   heading = {
  --     sign = false,
  --     icons = {},
  --   },
  -- },
}

packadd {
  'lewis6991/gitsigns.nvim',
  opts = {
    attach_to_untracked = false,
    signcolumn = false,
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
}

packadd {
  'b0o/incline.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = conf.incline,
}
