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
      view_options = {
        show_hidden = true,
      },
      lsp_file_methods = {
        autosave_changes = true,
      },
    })

    vim.keymap.set('n', '-', '<CMD>Oil<CR>')
  end
}
