vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<space><space>", "<C-^>", { silent = true })

-- Line moves
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- more moves
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })

-- Splits
vim.keymap.set("n", "vv", "<C-w>v", { silent = true })
vim.keymap.set("n", "ss", "<C-w>s", { silent = true })

-- Better paste
vim.keymap.set("x", "<leader>p", '"_dP', { silent = true })
vim.keymap.set("n", "<leader>yy", '"+y', { silent = true })
vim.keymap.set("v", "<leader>y", '"+y', { silent = true })

vim.keymap.set("n", "<leader>d", '"_d', { silent = true })
vim.keymap.set("v", "<leader>d", '"_d', { silent = true })

vim.keymap.set("n", "<leader>yp", function() yank_current_path() end, { silent = true })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { silent = true })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { silent = true })

vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-t>", ":vert term<CR>", { silent = true })

vim.keymap.set("n", "<left>", "gT")
vim.keymap.set("n", "<right>", "gt")
