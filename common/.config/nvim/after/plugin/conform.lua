require('conform').setup({
  formatter_by_ft = {
    javascriptreact = {
      { 'prettierd', 'prettier' },
      { 'eslint_d' },
    },
    typescriptreact = {
      { 'prettierd', 'prettier' },
      { 'eslint_d' },
    },
    javascript = {
      { 'prettierd', 'prettier' },
      { 'eslint_d' },
    },
    typescript = {
      { 'prettierd', 'prettier' },
      { 'eslint_d' },
    },
    lua = { 'stylua' },
    rust = { 'rustfmt' },
    go = { 'gofmt' },
  },
  format_on_save = {},
})

vim.o.formatexpr = 'v:lua.require("conform").formatexpr()'
vim.keymap.set('n', '<leader>f', function()
  require('conform').format({ async = true, lsp_fallback = true })
end)
