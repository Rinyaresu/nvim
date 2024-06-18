vim.tbl_add_reverse_lookup = function(tbl)
  for k, v in pairs(tbl) do
    tbl[v] = k
  end
end

return {
  {
    'pmizio/typescript-tools.nvim',
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
