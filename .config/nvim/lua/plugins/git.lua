return {
  'sindrets/diffview.nvim',
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
        integrations = {
          diffview = true,
        }
      })

      vim.keymap.set('n', '<leader>gg', ':Neogit<cr>', { silent = true })
    end
  },
}
