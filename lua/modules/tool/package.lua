local conf = require 'modules.tool.config'

packadd {
  'otavioschwanck/arrow.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
  config = conf.arrow,
}

packadd {

  'NeogitOrg/neogit',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  config = conf.neogit,
}

packadd {
  'wakatime/vim-wakatime',
}

packadd {
  'mbbill/undotree',
}

packadd {
  'christoomey/vim-tmux-navigator',
  lazy = true,
  event = 'BufEnter',
}

packadd {
  'rest-nvim/rest.nvim',
  lazy = true,
  ft = { 'http' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, 'http')
    end,
  },
}
