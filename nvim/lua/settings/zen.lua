require('twilight').setup()

require('zen-mode').setup({
  window = {
    backdrop = 1,
    width = .5 -- width will be 85% of the editor width
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
  }
})
