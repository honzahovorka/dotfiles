require('project_nvim').setup({
  detection_methods = { 'pattern', 'lsp' },
  patterns = { 'package.json', '.git' },
  ignore_lsp = { 'null-ls' },
})
