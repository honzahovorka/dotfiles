return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local icons = require('icons')

      local filetype = { 'filetype', icon_only = true }
      local diagnostics = {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = {
          error = icons.diagnostics.BoldError .. ' ',
          hint = icons.diagnostics.BoldHint .. ' ',
          info = icons.diagnostics.BoldInformation .. ' ',
          warn = icons.diagnostics.BoldWarning .. ' ',
        },
        colored = true,
        update_in_insert = false,
        always_visible = false,
      }

      local diff = {
        'diff',
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,

        symbols = {
          added = icons.git.LineAdded .. ' ',
          modified = icons.git.LineModified .. ' ',
          removed = icons.git.LineRemoved .. ' ',
        },
        colored = true,
        always_visible = false,
      }

      local branch = {
        'branch',
        icon = icons.git.Branch .. ' ',
      }

      local opts = {
        extensions = { 'oil', 'trouble' },
        options = {
          component_separators = icons.status.ComponentSeparator,
          section_separators = { left = icons.status.SeparatorRight, right = icons.status.SeparatorLeft },

        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = icons.status.SeparatorLeft }, right_padding = 2 },
          },
          lualine_b = { 'filename' },
          lualine_c = { branch, diff },
          lualine_x = { diagnostics, filetype },
          lualine_y = { 'progress' },
          lualine_z = {
            { 'location', separator = { right = icons.status.SeparatorRight }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
      }

      require('lualine').setup(opts)
    end
  }
}
