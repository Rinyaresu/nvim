local M = {}

function M.lsp_config()
  -- Enable completion triggered by <c-x><c-o>
  local function on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end

  local lspconfig = require 'lspconfig'
  local mason_lspconfig = require 'mason-lspconfig'
  local capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  vim.cmd [[
            highlight! DiagnosticVirtualTextError guifg=#DCD7BA gui=italic
            highlight! DiagnosticVirtualTextWarn  guifg=#DCD7BA gui=italic
            highlight! DiagnosticVirtualTextInfo  guifg=#DCD7BA gui=italic
            highlight! DiagnosticVirtualTextHint  guifg=#DCD7BA gui=italic
            " highlight! DiagnosticLineError guibg=#43242B
            " highlight! DiagnosticLineWarn guibg=#49443C
            " highlight! DiagnosticLineInfo guibg=#2D4F67
            " highlight! DiagnosticLineHint guibg=#54546D
            highlight! DiagnosticLineError guibg=#F4E2E5
            highlight! DiagnosticLineWarn  guibg=#F6EEE2
            highlight! DiagnosticLineInfo  guibg=#E1F0F5
            highlight! DiagnosticLineHint  guibg=#E3EEEE
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

  local ensure_installed = vim.tbl_keys {}
  vim.list_extend(ensure_installed, {
    'lua_ls',
    'stylua',
    'jsonls',
    'html',
    'cssls',
    'prettier',
    'marksman',
    'ts_ls',
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  mason_lspconfig.setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      lspconfig[server_name].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end,

    ['html'] = function()
      lspconfig.html.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { 'html' },
      }
    end,

    ['astro'] = function()
      lspconfig.astro.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { 'astro' },
      }
    end,

    ['jsonls'] = function()
      lspconfig.jsonls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        commands = {
          Format = {
            function()
              vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line '$', 0 })
            end,
          },
        },
      }
    end,
  }

  lspconfig['solargraph'].setup {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      client.server_capabilities.documentFormattingProvider = true -- we want to use rubocop
    end,
    capabilities = capabilities,
    filetypes = { 'ruby', 'eruby' },
    settings = {
      solargraph = {
        useBundler = true,
        diagnostic = true,
        completion = true,
        hover = true,
        formatting = true,
        symbols = true,
        definitions = true,
        rename = true,
        references = true,
        folding = true,
      },
    },
  }
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
