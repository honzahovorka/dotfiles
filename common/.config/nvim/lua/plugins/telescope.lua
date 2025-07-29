return {
  {
    'nvim-telescope/telescope.nvim',
    priority = 100,
    config = function()
      local data = assert(vim.fn.stdpath('data'))

      require('telescope').setup({
        defaults = {
          prompt_prefix = '❯ ',
          selection_caret = '❯ ',
          path_display = {
            'filename_first',
          },
        },

        pickers = {
          find_files = {
            find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
          },
          grep_string = {
            additional_args = { '--hidden' }
          },
          live_grep = {
            additional_args = { '--hidden' }
          },
        },

        extensions = {
          history = {
            path = vim.fs.joinpath(data, 'telescope_history.sqlite3'),
            limit = 100,
          },

          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = 'smart_case',       -- or 'ignore_case' or 'respect_case'
          },

          ['ui-select'] = {
            require('telescope.themes').get_dropdown({}),
          },
        },
      })

      vim.keymap.set('n', '<leader>fs', function()
        require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') })
      end)
      vim.keymap.set('n', '<leader>fw', function()
        local word = vim.fn.expand('<cword>')
        require('telescope.builtin').grep_string({ search = word })
      end)
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
          winblend = 0,
          previewer = false,
        }))
      end, { silent = true })
      vim.keymap.set('n', '<leader>gwt', function()
        require('telescope').extensions.git_worktree.git_worktrees()
      end, { silent = true })
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  'nvim-telescope/telescope-ui-select.nvim',
  {
    'nvim-telescope/telescope-smart-history.nvim',
    dependencies = {
      'kkharji/sqlite.lua'
    },
  },
  {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
      'kkharji/sqlite.lua'
    },
    opts = {}
  },
}
