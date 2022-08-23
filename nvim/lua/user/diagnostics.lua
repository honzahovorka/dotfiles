local nvim_lsp = require'lspconfig'
local protocol = require'vim.lsp.protocol'

vim.lsp.set_log_level("debug")

nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  init_options = {
    linters = {
      eslint = {
        command = 'eslint_d',
        rootPatterns = { '.git' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        sourceName = 'eslint_d',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
    },
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint'
    },
    formatters = {
      eslint_d = {
        command = 'eslint_d',
        args = { vim.api.nvim_buf_get_name(0), '--fix' },
        rootPatterns = { '.git' },
        formatStdin = true
      },
    },
    formatFiletypes = {
      javascript = 'eslint_d',
      javascriptreact = 'eslint_d',
      typescript = 'eslint_d',
      typescriptreact = 'eslint_d',
    }
  }
}
