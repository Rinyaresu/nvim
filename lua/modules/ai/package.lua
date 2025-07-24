local conf = require 'modules.ai.config'

packadd {
  'olimorris/codecompanion.nvim',
  event = 'BufEnter',
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
