local cmp = require('cmp')
local lspkind = require('lspkind')

require('copilot_cmp').setup({})

lspkind.init {
  symbol_map = {
    Copilot = '',
  },
}
vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert,noselect'

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<C-n>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end
    }),
    ['<C-p>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'copilot' },
    { name = 'path' },
    { name = 'buffer', keyword_length = 5 },
  }),

  window = {
		completion = {
			border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
			winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:Normal',
		},
		documentation = {
			border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
      winhighlight = 'FloatBorder:NormalFloat',
		},
	},

  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = '[buf]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[api]',
        path = '[path]',
        copilot = '[copilot]',
      }
    }
  }
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})

vim.cmd([[
  hi! default link CmpItemAbbr Normal
  hi! default link CmpItemAbbrDeprecated Error
  hi! default link CmpItemAbbrMatch Function
  hi! default link CmpItemKind Function
  hi! default link CmpItemMenu Comment
]])
