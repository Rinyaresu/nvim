local M = {}

function M.lsp_config()
  -- Enable completion triggered by <c-x><c-o>
  local function on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end

  local capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local mason_servers = {
    'lua_ls',
    'jsonls',
    'html',
    'cssls',
    'marksman',
  }

  vim.cmd [[
            highlight! DiagnosticVirtualTextError guifg=#DCD7BA gui=italic
            highlight! DiagnosticVirtualTextWarn guifg=#DCD7BA gui=italic
            highlight! DiagnosticVirtualTextInfo guifg=#DCD7BA gui=italic
            highlight! DiagnosticVirtualTextHint guifg=#DCD7BA gui=italic
            highlight! DiagnosticLineError guibg=#F3E6E2
            highlight! DiagnosticLineWarn guibg=#F8EBDB
            highlight! DiagnosticLineInfo guibg=#EAEAE5
            highlight! DiagnosticLineHint guibg=#EFE8E6
          ]]

  vim.diagnostic.config {
    virtual_text = true,
    signs = {
      linehl = {
        [vim.diagnostic.severity.ERROR] = 'DiagnosticLineError',
        [vim.diagnostic.severity.WARN] = 'DiagnosticLineWarn',
        [vim.diagnostic.severity.INFO] = 'DiagnosticLineInfo',
        [vim.diagnostic.severity.HINT] = 'DiagnosticLineHint',
      },
    },
  }

  require('mason').setup {
    ui = {
      border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
    },
  }

  require('mason-lspconfig').setup {
    automatic_installation = { exclude = { 'ruby_lsp', 'ts_ls' } },
    ensure_installed = mason_servers,
  }

  vim.lsp.config('*', {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  for _, server in ipairs(mason_servers) do
    vim.lsp.config(server, {})
  end

  vim.lsp.config('html', {
    filetypes = { 'html' },
  })

  vim.lsp.config('jsonls', {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line '$', 0 })
        end,
      },
    },
  })

  vim.lsp.config('ts_ls', {})

  vim.lsp.config('ruby_lsp', {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      client.server_capabilities.documentFormattingProvider = true
    end,
    filetypes = { 'ruby', 'eruby' },
  })

  vim.lsp.enable 'ts_ls'
  vim.lsp.enable 'ruby_lsp'

  -- Solargraph alternative (commented out)
  -- vim.lsp.config('solargraph', {
  --   on_attach = function(client, bufnr)
  --     on_attach(client, bufnr)
  --     client.server_capabilities.documentFormattingProvider = false
  --   end,
  --   cmd = { 'bundle', 'exec', 'solargraph', 'stdio' },
  --   filetypes = { 'ruby', 'eruby' },
  -- })
  -- vim.lsp.enable('solargraph')
end

function M.lsp_saga()
  require('lspsaga').setup {
    ui = { use_nerd = true, devicon = true },
    symbol_in_winbar = {
      enable = false,
    },
    lightbulb = {
      enable = false,
    },
    outline = {
      layout = 'float',
    },
  }
end

return M
