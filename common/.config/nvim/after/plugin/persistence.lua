require('persistence').setup({
  dir = vim.fn.expand(vim.fn.stdpath('state') .. '/sessions/'),
  options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp' }
})

vim.keymap.set("n", "<leader>qs", function() require("persistence").save() end, { desc = "Save session" })
vim.keymap.set("n", "<leader>ql", function() require("persistence").load() end, { desc = "Load session" })
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't save session" })
