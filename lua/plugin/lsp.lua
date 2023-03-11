---
---
-- See :help lspconfig-global-defaults
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

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
	virtual_text = true,
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

		bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
		bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
		bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
		bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
		bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
		bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
		bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
		bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
		bufmap('n', 'fc', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
		bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
		bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
		bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
		bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
		bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
	end
})

---
-- LSP servers
---

-- Prevent multiple instance of lsp servers
-- if file is sourced again
if vim.g.lsp_setup_ready == nil then
	vim.g.lsp_setup_ready = true

	-- See :help lspconfig-setup
	lspconfig.html.setup({})
	lspconfig.cssls.setup({})
	lspconfig.eslint.setup({})
	lspconfig.lua_ls.setup({
		settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { 'vim' },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
			},
		},
	})
	lspconfig.tailwindcss.setup {}
	lspconfig.tsserver.setup({
		settings = {
			completions = {
				completeFunctionCalls = true
			}
		},
	})
	lspconfig.solargraph.setup {
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
end
