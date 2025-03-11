local conf = require 'modules.lsp.config'

packadd {
  'neovim/nvim-lspconfig',
  lazy = false,
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
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
