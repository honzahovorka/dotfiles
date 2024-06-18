return {
  'kevinhwang91/nvim-bqf',
  ft = 'qf',
  dependencies = { 'junegunn/fzf' },
  config = function()
    require('bqf').setup({
      preview = {
        winblend = 0,
      },
    })
  end,
}
