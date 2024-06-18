return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim',           config = true }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    {
      'j-hui/fidget.nvim',
      config = function()
        require('fidget').setup({
          notification = {
            window = {
              winblend = 0,
            },
          }
        })
      end
    },
    { 'folke/neodev.nvim',                 opts = {} },
    { 'dmmulroy/ts-error-translator.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('custom-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func)
          vim.keymap.set('n', keys, func, { buffer = event.buf })
        end

        map('gd', require('telescope.builtin').lsp_definitions)
        map('gr', require('telescope.builtin').lsp_references)
        map('gI', require('telescope.builtin').lsp_implementations)
        map('<leader>D', require('telescope.builtin').lsp_type_definitions)
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols)
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols)
        map('<leader>rn', vim.lsp.buf.rename)
        map('<leader>ca', vim.lsp.buf.code_action)
        map('K', vim.lsp.buf.hover)
        map('gD', vim.lsp.buf.declaration)

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup('custom-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('custom-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'custom-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(true)
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
          end)
        end

        local border = {
          { '╭', 'FloatBorder' },
          { '─', 'FloatBorder' },
          { '╮', 'FloatBorder' },
          { '│', 'FloatBorder' },
          { '╯', 'FloatBorder' },
          { '─', 'FloatBorder' },
          { '╰', 'FloatBorder' },
          { '│', 'FloatBorder' },
        }

        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = {
      tsserver = {
        init_options = {
          preferences = {
            importModuleSpecifierPreference = 'relative'
          }
        },
        filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
        settings = {
          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = false,
            },
          },
          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = false,
            },
          },
        }
      },

      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            diagnostics = {
              globals = { 'vim' },
            },

            hint = {
              enable = true,
            },
          },
        },
      },
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })

    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
    require('mason-lspconfig').setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      }
    })
  end
}
