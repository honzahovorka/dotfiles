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
  {
    'NeogitOrg/neogit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('neogit').setup({
        kind = 'split',
        integrations = {
          diffview = true,
        }
      })

      vim.keymap.set('n', '<leader>ng', ':Neogit<cr>', { silent = true })
    end
  },
}
