local telescope = require('telescope')

telescope.setup({
  defaults = {
    prompt_prefix = '❯ ',
    selection_caret = '❯ ',
  },

  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  }
})

telescope.load_extension('fzf')
telescope.load_extension('file_browser')
telescope.load_extension('harpoon')
telescope.load_extension('ui-select')
