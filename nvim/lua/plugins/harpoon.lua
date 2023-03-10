return {
  {
    'ThePrimeagen/harpoon',
    config = function()
      require('harpoon').setup({})

      vim.keymap.set('n', '<leader>a', ':lua require("harpoon.mark").add_file()<CR>', { silent = true })
      vim.keymap.set('n', '<C-e>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { silent = true })

      vim.keymap.set('n', '<leader>1', ':lua require("harpoon.ui").nav_file(1)<CR>', { silent = true })
      vim.keymap.set('n', '<leader>2', ':lua require("harpoon.ui").nav_file(2)<CR>', { silent = true })
      vim.keymap.set('n', '<leader>3', ':lua require("harpoon.ui").nav_file(3)<CR>', { silent = true })
      vim.keymap.set('n', '<leader>4', ':lua require("harpoon.ui").nav_file(4)<CR>', { silent = true })
    end
  }
}
