return {
  'mrquantumcodes/bufferchad.nvim',
  config = function ()
    require('bufferchad').setup({
      order = 'LAST_USED_UP', -- LAST_USED_UP (default)/ASCENDING/DESCENDING/REGULAR
      style = 'telescope',
    })
  end
}
