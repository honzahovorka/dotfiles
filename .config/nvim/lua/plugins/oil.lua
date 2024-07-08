return {
  'stevearc/oil.nvim',
  dependencies = { "echasnovski/mini.icons" },
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

    vim.keymap.set('n', '<space>-', '<CMD>Oil<CR>')
    vim.keymap.set('n', '-', require('oil').toggle_float)
  end
}
