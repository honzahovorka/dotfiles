return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local nvim_lsp = require('lspconfig')
      local protocol = require('vim.lsp.protocol')
      local null_ls = require('null-ls')

      require('mason').setup()

      local lsp_servers = {
        'tsserver',
        'lua_ls',
        'gopls',
        'vimls',
        'yamlls',
        'terraformls',
        'dockerls',
        'jsonls',
        'eslint',
      }

      require('mason-lspconfig').setup({
        ensure_installed = lsp_servers,
      })

      vim.cmd [[autocmd ColorScheme * hi! link FloatBorder Normal]]
      vim.cmd [[autocmd ColorScheme * hi! link NormalFloat Normal]]

      -- draw a border around the hover and signature help boxes
      local border = {
        { "╭", 'FloatBorder' },
        { "─", 'FloatBorder' },
        { "╮", 'FloatBorder' },
        { "│", 'FloatBorder' },
        { "╯", 'FloatBorder' },
        { "─", 'FloatBorder' },
        { "╰", 'FloatBorder' },
        { "│", 'FloatBorder' },
      }

      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        --Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap = true, silent = true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', '<space>h', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

        buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
        buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        buf_set_keymap('n', '<space>sd', '<cmd>lua require("telescope.builtin").diagnostics()<CR>', opts)
        buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)

        -- formatting
        if client.name == 'tsserver' then
          local ts_utils = require('nvim-lsp-ts-utils')
          ts_utils.setup({})
          ts_utils.setup_client(client)
        end

        --protocol.SymbolKind = { }
        protocol.CompletionItemKind = {
          '', -- Text
          '', -- Method
          '', -- Function
          '', -- Constructor
          '', -- Field
          '', -- Variable
          '', -- Class
          'ﰮ', -- Interface
          '', -- Module
          '', -- Property
          '', -- Unit
          '', -- Value
          '', -- Enum
          '', -- Keyword
          '﬌', -- Snippet
          '', -- Color
          '', -- File
          '', -- Reference
          '', -- Folder
          '', -- EnumMember
          '', -- Constant
          '', -- Struct
          '', -- Event
          'ﬦ', -- Operator
          '', -- TypeParameter
        }

        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
      end

      vim.diagnostic.config({
        underline = true,
        float = {
          show_header = true,
          border = border,
        },

        severity_sort = true,
        -- delay update diagnostics
        update_in_insert = false,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      nvim_lsp.tsserver.setup({
        init_options = {
          preferences = {
            importModuleSpecifierPreference = 'relative'
          }
        },
        on_attach = on_attach,
        filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
        capabilities = capabilities,
      })

      nvim_lsp.gopls.setup({
        on_attach = on_attach,
        filetypes = { 'go', 'gomod' },
        cmd = { 'gopls', '--remote=auto' },
        rootPatterns = { 'go.mod', '.git' },
        capabilities = capabilities,
      })

      nvim_lsp.rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        -- cmd = { "rustup", "run", "nightly", "rust-analyzer" },
      })

      nvim_lsp.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              -- Setup your lua path
              path = vim.split(package.path, ';'),
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
              },
            },
          },
        },
      })

      nvim_lsp.eslint.setup({
        root_dir = require('lspconfig.util').root_pattern(
        '.eslintrc.js',
        'node_modules',
        '.git'
        ),
        on_attach = on_attach,
        capabilities = capabilities,
      })

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
        },
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },
  {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end
  },
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'simrat39/inlay-hints.nvim',
  'folke/neodev.nvim',
  'jose-elias-alvarez/null-ls.nvim',
  'jose-elias-alvarez/nvim-lsp-ts-utils',
}
