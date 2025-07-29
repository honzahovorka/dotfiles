return {
  {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup({
        position = 'bottom', -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
      })

      vim.keymap.set('n', '<leader>xt', '<cmd>Trouble<cr>', { silent = true })
      vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { silent = true })
      vim.keymap.set('n', '<leader>xj', '<cmd>Trouble diagnostics next skip_groups=true jump=true<cr>', { silent = true })
      vim.keymap.set('n', '<leader>xk', '<cmd>Trouble diagnostics prev skip_groups=true jump=true<cr>', { silent = true })
    end
  },
}
