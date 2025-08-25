-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/vtsls.lua

return {
  cmd = { 'vtsls', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  root_markers = { 'package.json', 'package-lock.json', 'tsconfig.json', 'pnpm-lock.yaml', 'yarn.lock', 'bun.lock' },
}
