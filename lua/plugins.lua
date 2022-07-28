return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Automagic tabs vs. spaces
  use 'tpope/vim-sleuth'

  -- lsp
  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig' -- Start language servers

  -- nvim-cmp et. al.: Add autocomplete, hover, signature help
  use 'hrsh7th/nvim-cmp'
  use 'onsails/lspkind-nvim'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'

  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  use 'dense-analysis/ale'

  use 'gruvbox-community/gruvbox'

  use 'nvim-treesitter/nvim-treesitter'

  use 'mfussenegger/nvim-dap'
  use 'leoluz/nvim-dap-go'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'nvim-telescope/telescope-dap.nvim'

  -- :Git and git blame (<leader>gb)
  use 'tpope/vim-fugitive'
  use 'tveskag/nvim-blame-line'

  -- Dev icons: Assumes a patched font. Telescope and completion plugins use them
  use 'kyazdani42/nvim-web-devicons'

  use {'iamcco/markdown-preview.nvim', run = "cd app && yarn install"}

  -- highlight (<leader>h)
  use 'junegunn/limelight.vim'
end)
