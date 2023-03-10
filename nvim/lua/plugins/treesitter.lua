return {
  'nvim-treesitter/nvim-treesitter',
  'nvim-treesitter/playground',
  'nvim-treesitter/nvim-treesitter-textobjects',
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup({
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
          },
          rust = {
            'impl_item',
            'struct',
            'enum',
          },
        },
      })
    end,
  },
}
