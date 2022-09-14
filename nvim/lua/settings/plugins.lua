-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- stylua: ignore start
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Appearance
  use 'nvim-lua/popup.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'arkav/lualine-lsp-progress'
  use 'sindrets/diffview.nvim'
  use 'tpope/vim-fugitive'
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  }
  use 'f-person/git-blame.nvim'
  use 'projekt0n/github-nvim-theme'
  use {
    'sonph/onehalf',
    rtp = 'vim',
    config = function() vim.cmd('colorscheme onehalflight') end,
    event = 'VimEnter',
  }
  use {
    'catppuccin/nvim',
    as = 'catppuccin',
  }
  use 'cormacrelf/dark-notify'
  use 'lukas-reineke/indent-blankline.nvim'

  -- Project
  use 'editorconfig/editorconfig-vim'
  use 'vim-test/vim-test'
  use 'tpope/vim-unimpaired'
  use {
    'akinsho/toggleterm.nvim', tag = 'v2.*',
  }
  use {
    'phaazon/hop.nvim', branch = 'v2',
  }
  use 'ThePrimeagen/harpoon'

  -- Languages
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'simrat39/rust-tools.nvim'
  use 'crispgm/nvim-go'

  -- Misc
  use 'AndrewRadev/splitjoin.vim'
  use 'numToStr/Comment.nvim'
  use 'vim-scripts/camelcasemotion'
  use 'tpope/vim-surround'
  use 'godlygeek/tabular'
  use 'kyazdani42/nvim-web-devicons'
  use 'rcarriga/nvim-notify'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  }
  use 'nvim-telescope/telescope-file-browser.nvim'
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }


  -- LSP support
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use {
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp' },
  }
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lua'
  use 'onsails/lspkind-nvim'
  use {
    'tzachar/cmp-tabnine',
    after = 'nvim-cmp',
    run = './install.sh',
    requires = 'hrsh7th/nvim-cmp',
  }
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'

  -- Snippets
  use 'SirVer/ultisnips'
  use 'quangnguyen30192/cmp-nvim-ultisnips'

end)
