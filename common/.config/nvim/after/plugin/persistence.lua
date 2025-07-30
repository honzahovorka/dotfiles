require('persistence').setup({
  dir = vim.fn.expand(vim.fn.stdpath('state') .. '/sessions/'),
  options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp' }
})

-- Auto-restore session if no files were opened
vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('restore_session', { clear = true }),
  callback = function()
    if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
      require('persistence').load()
    end
  end,
  nested = true,
})

vim.keymap.set("n", "<leader>qs", function() require("persistence").save() end, { desc = "Save session" })
vim.keymap.set("n", "<leader>ql", function() require("persistence").load() end, { desc = "Load session" })
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't save session" })
