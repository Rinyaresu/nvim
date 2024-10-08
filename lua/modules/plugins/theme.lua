return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    init = function()
      require('catppuccin').setup {
        color_overrides = {
          mocha = {
            base = '#181818',
            mantle = '#181818',
            crust = '#181818',
            text = '#FFFFFF',
          },
          latte = {
            base = '#f8f8f7',
            text = '#654735',
            mantle = '#F5F5F0',
            crust = '#F5F5F0',
          },
        },

        styles = {
          comments = { 'italic' },
          functions = { 'bold' },
          keywords = { 'italic' },
          operators = { 'bold' },
          conditionals = { 'bold' },
          loops = { 'bold' },
          booleans = { 'bold', 'italic' },
          numbers = {},
          types = {},
          strings = {},
          variables = {},
          properties = {},
        },

        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
            },
            underlines = {
              errors = { 'underline' },
              hints = { 'underline' },
              warnings = { 'underline' },
              information = { 'underline' },
            },
          },

          telescope = { enabled = true, style = 'nvchad' },
        },
      }

      vim.cmd.colorscheme 'catppuccin-latte'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
