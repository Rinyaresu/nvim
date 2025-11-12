local conf = require 'modules.lsp.config'

packadd {
  'neovim/nvim-lspconfig',
  lazy = false,
  dependencies = {
    { 'williamboman/mason.nvim', commit = 'fc98833' },
    { 'williamboman/mason-lspconfig.nvim', commit = '1a31f82' },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    { 'folke/neodev.nvim' },
  },
  config = conf.lsp_config,
}

packadd {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  config = conf.lsp_saga,
}

packadd {
  'kchmck/vim-coffee-script',
}
