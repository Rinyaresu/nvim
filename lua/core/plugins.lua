require('plugin.lualine')
require('plugin.treesitter')
require('plugin.nvim-cmp')
require('plugin.lsp')
require('plugin.chatgpt')

---
-- Colorscheme
---
vim.cmd.colorscheme('tokyonight-night')

---
-- autopairs
---
require("nvim-autopairs").setup {}

---
-- indent blankline
---
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#f7768e gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#e0af68 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#9ece6a gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#7dcfff gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#7aa2f7 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#9d7cd8 gui=nocombine]]

require("indent_blankline").setup {
	space_char_blankline = " ",
	char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
	},
}
---
-- colorizer
---
require 'colorizer'.setup()

---
-- bufferline
---
-- see :help bufferline-settings
require('bufferline').setup({
	options = {
		mode = 'buffers',
		offsets = {
			{ filetype = 'nvimtree' }
		},
	},
	-- :help bufferline-highlights
	highlights = {
		buffer_selected = {
			italic = false
		},
		indicator_selected = {
			fg = { attribute = 'fg', highlight = 'function' },
			italic = false
		}
	}
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

require('telescope').load_extension('fzf')

---
-- mind
---
-- See :help mind.setup

require 'mind'.setup {}


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
-- Copilot
---
vim.g.copilot_assume_mapped = true


---
-- Blamer
---
vim.g.blamer_enabled = 1
