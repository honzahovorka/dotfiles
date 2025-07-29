return {
  'tpope/vim-sleuth',
  'nvim-lua/popup.nvim',
  'nvim-lualine/lualine.nvim',
  'editorconfig/editorconfig-vim',
  'tpope/vim-unimpaired',
  'AndrewRadev/splitjoin.vim',
  'vim-scripts/camelcasemotion',
  'tpope/vim-surround',
  'nvim-tree/nvim-web-devicons',
  {
    'folke/neodev.nvim',
    config = function()
      require('neodev').setup()
    end
  },
}
