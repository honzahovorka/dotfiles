-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

keymap({ 'n', 'v' }, '<Space>', '<Nop>', opts)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


keymap('i', 'jj', '<ESC>', opts)
keymap('n', '<space><space>', '<C-^>', opts)

-- Splits
keymap('n', 'vv', '<C-w>v', opts)
keymap('n', 'ss', '<C-w>s', opts)

-- Better paste
keymap('v', '<leader>p', "'_dP", opts)

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Telescope
keymap('n', '<leader>ff', ':Telescope find_files<CR>', opts)
keymap('n', '<leader>gf', ':Telescope git_files<CR>', opts)
keymap('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
keymap('n', '<leader>fp', ':Telescope projects<CR>', opts)
keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)
