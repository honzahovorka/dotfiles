-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
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
  use 'airblade/vim-gitgutter'
  use 'projekt0n/github-nvim-theme'
  use 'cormacrelf/dark-notify'

  -- Project
  use 'editorconfig/editorconfig-vim'
--  use 'airblade/vim-rooter'
  use 'vim-test/vim-test'
  use 'tpope/vim-unimpaired'
  use 'tamago324/lir.nvim'

  -- Languages
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end, 
  }
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
  use 'tami5/lspsaga.nvim'
  use {
    'tzachar/cmp-tabnine', 
    after = "nvim-cmp",
    run='./install.sh',
    requires = 'hrsh7th/nvim-cmp',
  }
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'

  -- Snippets
  use 'SirVer/ultisnips'
  use 'quangnguyen30192/cmp-nvim-ultisnips'

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- stylua: ignore end

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

