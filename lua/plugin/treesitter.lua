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
