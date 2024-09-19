return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          vim.cmd [[
            highlight! DiagnosticLineError guibg=#F4E2E5 guisp=NONE
            highlight! DiagnosticLineWarn guibg=#F6EEE2 guisp=NONE
            highlight! DiagnosticLineInfo guibg=#E1F0F5 guisp=NONE
            highlight! DiagnosticLineHint guibg=#E3EEEE guisp=NONE
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

          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

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
        settings = {
          flags = {
            debounce_text_changes = 150,
          },
          solargraph = {
            useBundler = true,
            diagnostics = true,
            formatting = false,
            completion = true,
          },
        },
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
