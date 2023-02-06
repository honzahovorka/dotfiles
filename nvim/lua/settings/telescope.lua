local telescope = require('telescope')

telescope.setup({
  defaults = {
    prompt_prefix = '❯ ',
    selection_caret = '❯ ',
  },

  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
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
  },

  project = {
    hidden_files = false,
    theme = "dropdown",
    base_dirs = {
      '~/Code/payments-service/',
    },
  },

  repo = {
    list = {
      search_dirs = {
        '~/Code',
      },
    },
  },
})

telescope.load_extension('fzf')
telescope.load_extension('file_browser')
telescope.load_extension('harpoon')
telescope.load_extension('ui-select')
telescope.load_extension('project')
telescope.load_extension('projects')
telescope.load_extension('repo')
