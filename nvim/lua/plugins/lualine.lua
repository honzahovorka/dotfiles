return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local opts = {
        options = {
          component_separators = '|',
          section_separators = { left = '', right = '' },

        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
          },
          lualine_b = { 'filename' },
          lualine_c = {},
          lualine_x = { 'o:encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
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

      local function ins_left(component)
        table.insert(opts.sections.lualine_c, component)
      end

      ins_left {
        'branch',
        icon = '',
      }

      ins_left {
        'diff',
        -- Is it me or the symbol for modified us really weird
        symbols = { added = ' ', modified = '柳 ', removed = ' ' },
      }

      ins_left {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
      }

      require('lualine').setup(opts)
    end
  }
}
