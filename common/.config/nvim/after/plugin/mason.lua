local servers = require('lsp-servers')

require('mason-tool-installer').setup {
  ensure_installed = servers,
  auto_update = true,
  run_on_start = true,
}
