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
  { "nvim-tree/nvim-web-devicons" },
  { 'nvim-lualine/lualine.nvim' },
  { 'akinsho/bufferline.nvim' },
  { 'lukas-reineke/indent-blankline.nvim' },

  -- File explorer
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
  { 'kdheepak/lazygit.nvim' },

  -- Code manipulation
  { 'nvim-treesitter/nvim-treesitter' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'nvim-treesitter/nvim-treesitter-context' },
  { 'jxnblk/vim-mdx-js' },
  { 'numToStr/Comment.nvim' },
  { 'tpope/vim-surround' },
  { 'wellle/targets.vim' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-endwise' },
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'alvan/vim-closetag' },
  {
    'RRethy/vim-illuminate',
    lazy = true,
    enabled = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    event = { 'CursorMoved', 'InsertLeave' },
    config = function()
      require 'illuminate'.configure {
        filetypes_denylist = {
          'neotree',
          'neo-tree',
          'Telescope',
          'telescope',
        }
      }
    end
  },
  { 'otavioschwanck/cool-substitute.nvim' },

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
  { 'phaazon/mind.nvim',                  branch = 'v2.2', requires = { 'nvim-lua/plenary.nvim' }, },
  { 'stevearc/dressing.nvim' },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
      })
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  },
  { 'christoomey/vim-tmux-navigator' },
  { 'rcarriga/nvim-notify' },

  -- ltex
  { "barreiroleo/ltex-extra.nvim" },

  -- LSP support
  { 'neovim/nvim-lspconfig' },
  { 'j-hui/fidget.nvim' },
  { 'ray-x/lsp_signature.nvim' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'jose-elias-alvarez/null-ls.nvim' },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" }
    }
  },

  -- Ruby
  { 'vim-ruby/vim-ruby' },
  { 'weizheheng/ror.nvim' },

  -- Autocomplete
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'hrsh7th/cmp-emoji' },

  -- Snippets
  { 'L3MON4D3/LuaSnip' },
  { 'rafamadriz/friendly-snippets' },
})
