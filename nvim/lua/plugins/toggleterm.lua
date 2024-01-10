return {
  {
    'akinsho/toggleterm.nvim',
    version = 'v2.*',
    config = function()
      require('toggleterm').setup({
        -- size can be a number or function which is passed the current terminal
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,    -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
        -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true,   -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        persist_size = true,
        persist_mode = true,      -- if set to true (default) the previous terminal mode will be remembered
        -- direction = 'vertical' | 'horizontal' | 'tab' | 'float',
        close_on_exit = true,     -- close the terminal window when the process exits
        shell = vim.o.shell,      -- change the default shell
        auto_scroll = true,       -- automatically scroll to the bottom on terminal output
        direction = 'float',
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
          -- The border key is *almost* the same as 'nvim_open_win'
          -- see :h nvim_open_win for details on borders however
          -- the 'curved' border is a custom border type
          -- not natively supported but implemented in this plugin.
          -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
          -- like `size`, width and height can be a number or function which is passed the current terminal
          -- width = <value>,
          -- height = <value>,
          winblend = 3,
        },
        winbar = {
          enabled = false,
          name_formatter = function(term) --  term: Terminal
            return term.name
          end
        },
      })
    end,
  }
}
