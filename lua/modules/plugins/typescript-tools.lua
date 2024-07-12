return {
  {
    'pmizio/typescript-tools.nvim',
    event = {
      'BufRead *.js,*.jsx,*.mjs,*.cjs,*ts,*tsx',
      'BufNewFile *.js,*.jsx,*.mjs,*.cjs,*ts,*tsx',
    },
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      settings = {
        tsserver_plugins = {
          '@styled/typescript-styled-plugin',
        },
      },
    },
  },
}
