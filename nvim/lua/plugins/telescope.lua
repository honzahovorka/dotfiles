return {
  {
    'nvim-telescope/telescope.nvim',
    priority = 100,
    config = function()
      require('telescope').setup({
        defaults = {
          prompt_prefix = '❯ ',
          selection_caret = '❯ ',
        },

        pickers = {
          find_files = {
            find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
          },
        },

        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or 'ignore_case' or 'respect_case'
          },
          file_browser = {
            git_status = false,
            theme = 'ivy',
          },
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
        },

        project = {
          hidden_files = false,
          theme = 'dropdown',
          base_dirs = {
            '~/Code/payments-service/',
          },
        },
      })

      vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { silent = true })
      vim.keymap.set('n', '<leader>gf', ':Telescope git_files<CR>', { silent = true })
      vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { silent = true })
      vim.keymap.set('n', '<leader>fp', ':Telescope project<CR>', { silent = true })
      vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { silent = true })
      vim.keymap.set('n', '<leader>fo', ':Telescope oldfiles<CR>', { silent = true })
      vim.keymap.set('n', '<leader>ft', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { silent = true })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { silent = true })
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  'nvim-telescope/telescope-ui-select.nvim',
  'nvim-telescope/telescope-file-browser.nvim',
  'nvim-telescope/telescope-project.nvim',
  {
    'AckslD/nvim-neoclip.lua',
    config = function()
      require('neoclip').setup()
    end,
  },
}
