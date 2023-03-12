---
---
-- See :help lspconfig-global-defaults
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config
local setup, null_ls = pcall(require, "null-ls")
if not setup then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        vim.lsp.buf.formatting_sync({
          filter = function(client)
            --  only use null-ls for formatting instead of lsp server
            return client.name == "null-ls"
          end,
          bufnr = bufnr,
        })
      end,
    })
  end
end

require "lsp_signature".setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded"
  }
})

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

---
-- Diagnostic customization
---
local sign = function(opts)
  -- See :help sign_define()
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '' })

-- See :help vim.diagnostic.config()
vim.diagnostic.config({
  signs = true,
  underline = true,
  virtual_text = false,
  severity_sort = true,
  update_in_insert = false,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'rounded' }
)

---
-- LSP Keybindings
---
vim.api.nvim_create_autocmd('LspAttach', {
  group = group,
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = { buffer = true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- You can search each function in the help page.
    -- For example :help vim.lsp.buf.hover()

    -- bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    -- bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    -- bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    -- bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    -- bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    -- bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    -- bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    -- bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
    -- bufmap('n', 'fc', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
    -- bufmap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    -- bufmap('x', 'ga', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
    -- bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    -- bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    -- bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})

---
-- LSP servers
---


require('mason').setup({
  ui = { border = 'rounded' }
})

-- See :help mason-lspconfig-settings
require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'eslint',
    'html',
    'cssls',
    'tailwindcss',
    'marksman',
    'jsonls',
    'lua_ls',
    'vimls',
    'bashls',
  }
})

-- Prevent multiple instance of lsp servers
-- if file is sourced again
if vim.g.lsp_setup_ready == nil then
  vim.g.lsp_setup_ready = true

  require('mason-lspconfig').setup_handlers({
    function(server)
      lspconfig[server].setup({})
    end,
    ['tsserver'] = function()
      lspconfig.tsserver.setup({
        settings = {
          completions = {
            completeFunctionCalls = true
          }
        }
      })
    end,
  })

  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.diagnostics.eslint.with({
        condition = function(utils)
          return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
        end,
      }),
    }
  })

  require("mason-null-ls").setup({
    ensure_installed = {
      'prettier',
      'markdownlint',
      'shellcheck',
      'yamllint',
      'erb_lint',
      'sql-formatter',
      'commitlint',
      'haml-lint'
    },
    automatic_installation = false,
    automatic_setup = true, -- Recommended, but optional
  })

  -- See :help lspconfig-setup
  lspconfig.solargraph.setup {
    on_attach = function(client, bufnr)
      require "lsp_signature".on_attach(signature_setup, bufnr) -- Note: add in lsp client on-attach
    end,
    flags = {
      debounce_text_changes = 50,
    },
    settings = {
      solargraph = {
        useBundler = true,
        diagnostics = true,
        formatting = true,
        completion = true,
      }
    }
  }
  lspconfig.ltex.setup {
    capabilities = your_capabilities,
    on_attach = function(client, bufnr)
      -- your other on_attach functions.
      require("ltex_extra").setup {
        load_langs = { "pt-BR", "en-US" }, -- table <string> : languages for witch dictionaries will be loaded
        init_check = true,                 -- boolean : whether to load dictionaries on startup
        path = nil,                        -- string : path to store dictionaries. Relative path uses current working directory
        log_level = "none",                -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
      }
    end,
    settings = {
      ltex = {
        language = "en-US",
        additionalRules = {
          enablePickyRules = true,
          motherTongue = "pt-BR",
        },
      }
    }
  }
end
