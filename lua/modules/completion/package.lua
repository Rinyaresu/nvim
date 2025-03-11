local conf = require 'modules.completion.config'

packadd {
  'saghen/blink.cmp',
  dependencies = {
    'xzbdmw/colorful-menu.nvim',
  },
  config = conf.blink,
  build = 'cargo build --release',
  opts_extend = { 'sources.default' },
}

packadd {
  'stevearc/conform.nvim',
  config = conf.conform,
}
