-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

keymap({ 'n', 'v' }, '<Space>', '<Nop>', opts)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('i', 'jj', '<ESC>', opts)
keymap('n', '<space><space>', '<C-^>', opts)

-- Line moves
keymap('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- Splits
keymap('n', 'vv', '<C-w>v', opts)
keymap('n', 'ss', '<C-w>s', opts)

-- Better paste
keymap('v', '<leader>p', "'_dP", opts)
keymap('n', '<leader>yy', "'+y", opts)
keymap('v', '<leader>y', "'+y", opts)

keymap('n', '<leader>d', "'_d", opts)
keymap('v', '<leader>d', "'_d", opts)

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Better window navigation
-- keymap('n', '<C-h>', '<C-w>h', opts)
-- keymap('n', '<C-j>', '<C-w>j', opts)
-- keymap('n', '<C-k>', '<C-w>k', opts)
-- keymap('n', '<C-l>', '<C-w>l', opts)

-- Telescope
keymap('n', '<leader>ff', ':Telescope find_files<CR>', opts)
keymap('n', '<leader>gf', ':Telescope git_files<CR>', opts)
keymap('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
keymap('n', '<leader>fp', ':Telescope projects<CR>', opts)
keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)
keymap('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

-- Harpoon
keymap('n', '<leader>a', ':lua require("harpoon.mark").add_file()<CR>', opts)
keymap('n', '<C-e>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)

keymap('n', '<leader>1', ':lua require("harpoon.ui").nav_file(1)<CR>', opts)
keymap('n', '<leader>2', ':lua require("harpoon.ui").nav_file(2)<CR>', opts)
keymap('n', '<leader>3', ':lua require("harpoon.ui").nav_file(3)<CR>', opts)
keymap('n', '<leader>4', ':lua require("harpoon.ui").nav_file(4)<CR>', opts)

keymap('n', '<leader>gs', ':Gitsigns<CR>', opts)
keymap('n', '<leader>ng', ':Neogit<CR>', opts)
