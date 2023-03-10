return {
  'sindrets/diffview.nvim',
  'f-person/git-blame.nvim',
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()

      vim.keymap.set('n', '<leader>gs', ':Gitsigns<CR>', { silent = true })
    end
  },
}
