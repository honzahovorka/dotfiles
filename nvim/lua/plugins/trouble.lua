return {
  {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup({
        position = 'bottom', -- position of the list can be: bottom, top, left, right
        height = 25, -- height of the trouble list when position is top or bottom
      })

      vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { silent = true })
      vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', { silent = true })
    end
  },
}
