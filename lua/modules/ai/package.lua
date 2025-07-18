local conf = require 'modules.ai.config'

packadd {
  'olimorris/codecompanion.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim', branch = 'master' },
    'nvim-treesitter/nvim-treesitter',
  },
  config = conf.codecompanion,
}

packadd {
  'zbirenbaum/copilot.lua',
  dependencies = { 'fang2hou/blink-copilot' },
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = conf.copilot,
}
