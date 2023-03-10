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

-- more moves
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

-- Splits
keymap('n', 'vv', '<C-w>v', opts)
keymap('n', 'ss', '<C-w>s', opts)

-- Better paste
keymap('x', '<leader>p', '"_dP', opts)
keymap('n', '<leader>yy', '"+y', opts)
keymap('v', '<leader>y', '"+y', opts)

keymap('n', '<leader>d', '"_d', opts)
keymap('v', '<leader>d', '"_d', opts)

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Telescope
keymap('n', '<leader>ff', ':Telescope find_files<CR>', opts)
keymap('n', '<leader>gf', ':Telescope git_files<CR>', opts)
keymap('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
keymap('n', '<leader>fp', ':Telescope project<CR>', opts)
keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)
keymap('n', '<leader>fo', ':Telescope oldfiles<CR>', opts)
keymap('n', '<leader>ft', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', opts)
keymap('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, opts)

-- Harpoon
keymap('n', '<leader>a', ':lua require("harpoon.mark").add_file()<CR>', opts)
keymap('n', '<C-e>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)

keymap('n', '<leader>1', ':lua require("harpoon.ui").nav_file(1)<CR>', opts)
keymap('n', '<leader>2', ':lua require("harpoon.ui").nav_file(2)<CR>', opts)
keymap('n', '<leader>3', ':lua require("harpoon.ui").nav_file(3)<CR>', opts)
keymap('n', '<leader>4', ':lua require("harpoon.ui").nav_file(4)<CR>', opts)

keymap('n', '<leader>gs', ':Gitsigns<CR>', opts)
keymap('n', '<leader>ng', ':Neogit<CR>', opts)

keymap('n', '<Leader>u', ':UndotreeToggle<CR>', opts)

keymap('n', '<C-k>', '<cmd>cnext<CR>zz', opts)
keymap('n', '<C-j>', '<cmd>cprev<CR>zz', opts)

keymap('n', '<leader>xx', '<cmd>TroubleToggle<cr>', opts)
keymap('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)
