return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Automagic tabs vs. spaces
  use 'tpope/vim-sleuth'

  -- Language Server Protocol (LSP)
  use 'williamboman/mason.nvim' -- install and manage LSP, DAP, linter, and formatter plugins
  use 'williamboman/mason-lspconfig.nvim' -- help nvim-lspconfig find mason installed servers
  use 'neovim/nvim-lspconfig' -- configure plugins

  -- nvim-cmp et. al.: Add autocomplete, hover, signature help
  use 'hrsh7th/nvim-cmp'
  use 'onsails/lspkind-nvim' -- pictograms
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'

  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  use 'dense-analysis/ale'

  use 'gruvbox-community/gruvbox'

  use 'nvim-treesitter/nvim-treesitter'

  use 'akinsho/toggleterm.nvim'

  use('mrjones2014/smart-splits.nvim')

  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'

  use 'mfussenegger/nvim-dap'
  use 'leoluz/nvim-dap-go' -- configure delve
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'nvim-telescope/telescope-dap.nvim'

  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }

  -- :Git and git blame (<leader>gb)
  use 'tpope/vim-fugitive'
  use 'tveskag/nvim-blame-line'

  -- Dev icons: Assumes a patched font. Telescope and completion plugins use them
  use 'kyazdani42/nvim-web-devicons'

  use {'iamcco/markdown-preview.nvim', run = "cd app && yarn install"}

  -- highlight (<leader>h)
  use 'junegunn/limelight.vim'
end)
