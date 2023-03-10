-- Install packer
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            'git',
            'clone',
            '--depth',
            '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path,
        })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- stylua: ignore start
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Appearance
  use 'nvim-lua/popup.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'folke/lsp-colors.nvim'
  use 'sindrets/diffview.nvim'
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  }
  use 'f-person/git-blame.nvim'
  use {
    'catppuccin/nvim',
    as = 'catppuccin',
  }
  use 'cormacrelf/dark-notify'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'folke/zen-mode.nvim'
  use 'folke/twilight.nvim'
  use 'folke/trouble.nvim'

  -- Project
  use 'editorconfig/editorconfig-vim'
  use 'vim-test/vim-test'
  use 'tpope/vim-unimpaired'
  use {
    'akinsho/toggleterm.nvim', tag = 'v2.*',
  }
  use 'ThePrimeagen/harpoon'
  use 'ahmedkhalf/project.nvim'
  use 'mbbill/undotree'

  -- Languages
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  use 'simrat39/rust-tools.nvim'

  -- Misc
  use 'AndrewRadev/splitjoin.vim'
  use 'numToStr/Comment.nvim'
  use 'vim-scripts/camelcasemotion'
  use 'tpope/vim-surround'
  use 'godlygeek/tabular'
  use 'nvim-tree/nvim-web-devicons'
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
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'nvim-telescope/telescope-project.nvim'

  -- LSP support
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
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
  use 'zbirenbaum/copilot.lua'
  use 'zbirenbaum/copilot-cmp'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'j-hui/fidget.nvim'

  -- Snippets
  use 'SirVer/ultisnips'
  use 'quangnguyen30192/cmp-nvim-ultisnips'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
