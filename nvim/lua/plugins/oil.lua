return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup({
      columns = {
        'icon',
        'permissions',
        'size',
        'mtime',
      },
      lsp_rename_autosave = true,
      view_options = {
        show_hidden = true,
      },
    })

    vim.keymap.set('n', '-', '<CMD>Oil<CR>')
  end
}
