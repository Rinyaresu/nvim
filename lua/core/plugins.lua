require('plugin.lualine')
require('plugin.treesitter')
require('plugin.nvim-cmp')
require('plugin.lsp')
require('plugin.neorg')

---
-- LSP lines
---

require("lsp_lines").setup({})


---
-- Noice
--
require("noice").setup({
  lsp = {
    signature = {
      enabled = false,
    },
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true,         -- use a classic bottom cmdline for search
    command_palette = true,       -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },
})


---
-- Colorscheme
---
vim.cmd.colorscheme('tokyonight-night')


---
-- cool substitute
--
require 'cool-substitute'.setup({
  setup_keybindings = true,
  mappings = {
    start = 'gm',                                    -- Mark word / region
    start_and_edit = 'gM',                           -- Mark word / region and also edit
    start_and_edit_word = 'g!M',                     -- Mark word / region and also edit.  Edit only full word.
    start_word = 'g!m',                              -- Mark word / region. Edit only full word
    apply_substitute_and_next = 'M',                 -- Start substitution / Go to next substitution
    apply_substitute_and_prev = '<C-b>',             -- same as M but backwards
    apply_substitute_all = 'ga',                     -- Substitute all
    force_terminate_substitute = 'g!!',              -- Terminate macro (if some bug happens)
    terminate_substitute = '<esc>',                  -- Terminate macro
    skip_substitute = 'n',                           -- Skip this occurrence
    goto_next = '<C-j>',                             -- Go to next occurence
    goto_previous = '<C-k>',                         -- Go to previous occurrence
  },
  reg_char = 'o',                                    -- letter to save macro (Dont use number or uppercase here)
  mark_char = 't',                                   -- mark the position at start of macro
  writing_substitution_color = "#ECBE7B",            -- for status line
  applying_substitution_color = "#98be65",           -- for status line
  edit_word_when_starting_with_substitute_key = true -- (press M to mark and edit when not executing anything anything)
})


---
-- autopairs
---
require("nvim-autopairs").setup {}


---
-- indent blankline
---

require("indent_blankline").setup {
  use_treesitter = true,
  show_current_context = true,
  show_current_context_start = true,
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
