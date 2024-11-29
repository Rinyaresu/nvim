return {
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'mfussenegger/nvim-lint',

      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          vim.cmd [[
            highlight! DiagnosticVirtualTextError guifg=#DCD7BA gui=italic
            highlight! DiagnosticVirtualTextWarn  guifg=#DCD7BA gui=italic
            highlight! DiagnosticVirtualTextInfo  guifg=#DCD7BA gui=italic
            highlight! DiagnosticVirtualTextHint  guifg=#DCD7BA gui=italic
            highlight! DiagnosticLineError guibg=#43242B
            highlight! DiagnosticLineWarn guibg=#49443C
            highlight! DiagnosticLineInfo guibg=#2D4F67
            highlight! DiagnosticLineHint guibg=#54546D
          ]]

          vim.diagnostic.config {
            signs = {
              linehl = {
                [vim.diagnostic.severity.ERROR] = 'DiagnosticLineError',
                [vim.diagnostic.severity.WARN] = 'DiagnosticLineWarn',
                [vim.diagnostic.severity.INFO] = 'DiagnosticLineInfo',
                [vim.diagnostic.severity.HINT] = 'DiagnosticLineHint',
              },
            },
          }

          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          local fzf = require 'fzf-lua'

          map('gd', function()
            fzf.lsp_definitions()
          end, '[G]oto [D]efinition')

          map('gr', function()
            fzf.lsp_references()
          end, '[G]oto [R]eferences')

          map('gI', function()
            fzf.lsp_implementations()
          end, '[G]oto [I]mplementation')

          map('<leader>t', function()
            fzf.lsp_typedefs()
          end, 'Type [D]efinition')

          map('<leader>ds', function()
            fzf.lsp_document_symbols()
          end, '[D]ocument [S]ymbols')

          map('<leader>ws', function()
            fzf.lsp_workspace_symbols()
          end, '[W]orkspace [S]ymbols')

          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ga', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
          end

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
            end,
          })

          if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end
        end,
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      require('lint').linters_by_ft = {
        markdown = { 'markdownlint-cli2' },
      }

      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      -- Configure the solargraph LSP outside of mason
      -- This is because solargraph doesn't work well with mason
      require('lspconfig').solargraph.setup {
        capabilities,
        filetypes = { 'ruby', 'eruby' },
        settings = {
          flags = {
            debounce_text_changes = 150,
          },
          solargraph = {
            useBundler = true,
            diagnostic = true,
            completion = true,
            hover = true,
            formatting = false,
            symbols = true,
            definitions = true,
            rename = true,
            references = true,
            folding = true,
          },
        },
      }

      require('lspconfig').ts_ls.setup {
        init_options = {
          preferences = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            importModuleSpecifierPreference = 'non-relative',
          },
        },
        on_attach = function(client)
          client.server_capabilities.document_formatting = false
          client.server_capabilities.document_range_formatting = false
        end,
      }

      require('mason').setup()

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

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
