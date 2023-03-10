-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

require('core.set')

-- Shortcuts
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>h', '^')
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>l', 'g_')
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Basic clipboard interaction
vim.keymap.set({ 'n', 'x' }, 'y', '"+y')
vim.keymap.set({ 'n', 'x' }, 'p', '"+p')

-- Delete text
vim.keymap.set({ 'n', 'x' }, 'x', '"_x')

-- Commands
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
vim.keymap.set('n', '<leader>bq', '<cmd>bdelete<cr>')
vim.keymap.set('n', '<leader>bl', '<cmd>buffer #<cr>')

vim.keymap.set('n', 'H', '<cmd>BufferLineCyclePrev<cr><CR>')
vim.keymap.set('n', 'L', '<cmd>BufferLineCycleNext<CR>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})

local group = vim.api.nvim_create_augroup('user_cmds', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight on yank',
	group = group,
	callback = function()
		vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'help', 'man' },
	group = group,
	command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

vim.api.nvim_create_autocmd('BufEnter', {
	pattern = { '*.md' },
	group = group,
	command = 'setlocal wrap'
})

vim.api.nvim_create_autocmd("BufWritePre", {
	buffer = buffer,
	callback = function()
		vim.lsp.buf.format { async = false }
	end
})

-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

local lazy = {}

function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print('Installing lazy.nvim....')
		vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'https://github.com/folke/lazy.nvim.git',
			'--branch=stable', -- latest stable release
			path,
		})
	end
end

function lazy.setup(plugins)
	-- You can "comment out" the line below after lazy.nvim is installed
	lazy.install(lazy.path)

	vim.opt.rtp:prepend(lazy.path)
	require('lazy').setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
	-- Theming
	{ 'folke/tokyonight.nvim' },
	{ 'joshdick/onedark.vim' },
	{ 'tanvirtin/monokai.nvim' },
	{ 'lunarvim/darkplus.nvim' },
	{ 'kyazdani42/nvim-web-devicons' },
	{ 'nvim-lualine/lualine.nvim' },
	{ 'akinsho/bufferline.nvim' },
	{ 'lukas-reineke/indent-blankline.nvim' },

	-- File explorer
	{ 'kyazdani42/nvim-tree.lua' },
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		keys = {
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
			if vim.fn.argc() == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		opts = {
			filesystem = {
				bind_to_cwd = true,
				follow_current_file = true,
			},
			window = {
				mappings = {
					["<space>"] = "none",
				},
			},
		},
	},
	{ "MunifTanjim/nui.nvim" },

	-- Fuzzy finder
	{ 'nvim-telescope/telescope.nvim',              branch = '0.1.x' },
	{ 'nvim-telescope/telescope-fzf-native.nvim',   build = 'make' },

	-- Git
	{ 'APZelos/blamer.nvim' },
	{ 'lewis6991/gitsigns.nvim' },
	{ 'tpope/vim-fugitive' },
	{ 'sindrets/diffview.nvim',                     requires = 'nvim-lua/plenary.nvim' },

	-- Code manipulation
	{ 'nvim-treesitter/nvim-treesitter' },
	{ 'nvim-treesitter/nvim-treesitter-textobjects' },
	{ 'jxnblk/vim-mdx-js' },
	{ 'numToStr/Comment.nvim' },
	{ 'tpope/vim-surround' },
	{ 'wellle/targets.vim' },
	{ 'tpope/vim-repeat' },
	{ 'tpope/vim-endwise' },
	{ 'lukas-reineke/indent-blankline.nvim' },
	{ 'alvan/vim-closetag' },

	-- Utilities
	{ 'moll/vim-bbye' },
	{ 'nvim-lua/plenary.nvim' },
	{ 'editorconfig/editorconfig-vim' },
	{ 'akinsho/toggleterm.nvim' },
	{ 'windwp/nvim-autopairs' },
	{ 'norcalli/nvim-colorizer.lua' },
	{ 'mrjones2014/nvim-ts-rainbow' },
	{ 'mbbill/undotree' },
	{ 'github/copilot.vim' },
	{ 'wakatime/vim-wakatime' },
	{
		'jackMort/ChatGPT.nvim',
		keys = {
			{ "<leader>i", "<cmd>ChatGPT<CR>", desc = "ChatGPT" }
		},
		config = function()
			require("chatgpt").setup({
				welcome_message = "",
			})
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim"
		}
	},
	{ 'phaazon/mind.nvim',           branch = 'v2.2', requires = { 'nvim-lua/plenary.nvim' }, },
	{ 'stevearc/dressing.nvim' },

	-- LSP support
	{ 'neovim/nvim-lspconfig' },
	{ 'j-hui/fidget.nvim' },

	-- Ruby
	{ 'vim-ruby/vim-ruby' },

	-- Autocomplete
	{ 'hrsh7th/nvim-cmp' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'saadparwaiz1/cmp_luasnip' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-nvim-lua' },

	-- Snippets
	{ 'L3MON4D3/LuaSnip' },
	{ 'rafamadriz/friendly-snippets' },
})



-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- Colorscheme
---
vim.cmd.colorscheme('tokyonight-night')

---
-- vim-bbye
---
vim.keymap.set('n', '<leader>bc', '<cmd>Bdelete<CR>')

---
-- autopairs
---

require("nvim-autopairs").setup {}

---
-- indent blankline
---

require("indent_blankline").setup {
	char = '▏',
	show_trailing_blankline_indent = false,
	show_first_indent_level = false,
	use_treesitter = true,
	show_current_context = true
}

---
-- colorizer
---
require 'colorizer'.setup()


-- See :help lualine.txt
--

-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
	bg       = '#16161e',
	fg       = '#c0caf5',
	yellow   = '#e0af68',
	cyan     = '#86e1fc',
	darkblue = '#394b70',
	green    = '#4fd6be',
	orange   = '#ff966c',
	violet   = '#c099ff',
	magenta  = '#fca7ea',
	blue     = '#3e68d7',
	red      = '#ff757f',
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand('%:p:h')
		local gitdir = vim.fn.finddir('.git', filepath .. ';')
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = '',
		section_separators = '',
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left {
	function()
		return '▊'
	end,
	color = { fg = colors.blue },     -- Sets highlighting of component
	padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
	-- mode component
	function()
		return ''
	end,
	color = function()
		-- auto change color according to neovims mode
		local mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.blue,
			[''] = colors.blue,
			V = colors.blue,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			[''] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			['r?'] = colors.cyan,
			['!'] = colors.red,
			t = colors.red,
		}
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = { right = 1 },
}

ins_left {
	-- filesize component
	'filesize',
	cond = conditions.buffer_not_empty,
}

ins_left {
	'filename',
	cond = conditions.buffer_not_empty,
	color = { fg = colors.magenta, gui = 'bold' },
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
	'diagnostics',
	sources = { 'nvim_diagnostic' },
	symbols = { error = ' ', warn = ' ', info = ' ' },
	diagnostics_color = {
		color_error = { fg = colors.red },
		color_warn = { fg = colors.yellow },
		color_info = { fg = colors.cyan },
	},
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
	function()
		return '%='
	end,
}

ins_left {
	-- Lsp server name .
	function()
		local msg = 'No Active Lsp'
		local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = ' LSP:',
	color = { fg = '#ffffff', gui = 'bold' },
}

-- Add components to right sections
ins_right {
	'o:encoding',      -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	cond = conditions.hide_in_width,
	color = { fg = colors.green, gui = 'bold' },
}

ins_right {
	'fileformat',
	fmt = string.upper,
	icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
	color = { fg = colors.green, gui = 'bold' },
}

ins_right {
	'branch',
	icon = '',
	color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
	'diff',
	-- Is it me or the symbol for modified us really weird
	symbols = { added = ' ', modified = '柳 ', removed = ' ' },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.orange },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
}

ins_right {
	function()
		return '▊'
	end,
	color = { fg = colors.blue },
	padding = { left = 1 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)


---
-- bufferline
---
-- See :help bufferline-settings
require('bufferline').setup({
	options = {
		mode = 'buffers',
		offsets = {
			{ filetype = 'NvimTree' }
		},
	},
	-- :help bufferline-highlights
	highlights = {
		buffer_selected = {
			italic = false
		},
		indicator_selected = {
			fg = { attribute = 'fg', highlight = 'Function' },
			italic = false
		}
	}
})


---
-- Treesitter
---
-- See :help nvim-treesitter-modules
require('nvim-treesitter.configs').setup({
	highlight = {
		enable = true,
	},
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
	-- :help nvim-treesitter-textobjects-modules
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
			}
		},
	},
	ensure_installed = {
		'javascript',
		'typescript',
		'tsx',
		'lua',
		'css',
		'json',
		'ruby',
	},
})


---
-- Comment.nvim
---
require('Comment').setup({})


---
-- Indent-blankline
---
-- See :help indent-blankline-setup
require('indent_blankline').setup({
	char = '▏',
	show_trailing_blankline_indent = false,
	show_first_indent_level = false,
	use_treesitter = true,
	show_current_context = false
})


---
-- Gitsigns
---
-- See :help gitsigns-usage
require('gitsigns').setup({
	signs = {
		add = { text = '▎' },
		change = { text = '▎' },
		delete = { text = '➤' },
		topdelete = { text = '➤' },
		changedelete = { text = '▎' },
	}
})


---
-- Telescope
---
-- See :help telescope.builtin
vim.keymap.set('n', '<leader>?', '<cmd>Telescop/e oldfiles<cr>')
vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<CR>')
vim.keymap.set('n', '<leader><tab>', '<cmd>Telescope git_status<CR>')

require('telescope').load_extension('fzf')

---
-- mind
---
-- See :help mind.setup

vim.keymap.set('n', '<leader>mp', ':MindOpenMain<CR>')
vim.keymap.set('n', '<leader>mc', ':MindClose<CR>')

require 'mind'.setup {}


---
-- Undotree
--
vim.keymap.set('n', '<leader>fu', ":UndotreeToggle<CR> <BAR> :UndotreeFocus<CR>")

---
-- toggleterm
---
-- See :help toggleterm-roadmap
require('toggleterm').setup({
	open_mapping = '<C-g>',
	direction = 'horizontal',
	shade_terminals = true
})


---
-- Luasnip (snippet engine)
---
-- See :help luasnip-loaders
require('luasnip.loaders.from_vscode').lazy_load()

---
-- Fidget (Useful status updates for LSP)
---
require "fidget".setup {}

---
-- nvim-cmp (autocomplete)
---
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = { behavior = cmp.SelectBehavior.Select }

-- See :help cmp-config
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	sources = {
		{ name = 'path' },
		{ name = 'nvim_lsp', keyword_length = 1 },
		{ name = 'buffer',   keyword_length = 3 },
		{ name = 'luasnip',  keyword_length = 2 },
	},
	window = {
		documentation = cmp.config.window.bordered()
	},
	formatting = {
		fields = { 'menu', 'abbr', 'kind' },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = 'λ',
				luasnip = '⋗',
				buffer = 'Ω',
				path = '🖫',
			}

			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	-- See :help cmp-mapping
	mapping = {
		['<Up>'] = cmp.mapping.select_prev_item(select_opts),
		['<Down>'] = cmp.mapping.select_next_item(select_opts),
		['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
		['<C-n>'] = cmp.mapping.select_next_item(select_opts),
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
		['<C-e>'] = cmp.mapping.abort(),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		['<C-f>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<C-b>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<Tab>'] = cmp.mapping(function(fallback)
			local col = vim.fn.col('.') - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
				fallback()
			else
				cmp.complete()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
})

---
-- Copilot
---
vim.g.copilot_assume_mapped = true


---
-- ChatGPT
---
require("chatgpt").setup({})

---
-- Blamer
---
vim.g.blamer_enabled = 1

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
