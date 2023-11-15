local neotest = require('neotest')

neotest.setup({
  adapters = {
    require('neotest-jest')({
      jestCommand = 'npm run test --',
    }),
  },
  icons = {
    -- passed = '✔',
    -- failed = '✖',
    -- running = '◴',
    -- skipped = 'ﰸ',
    child_indent = "│",
    child_prefix = "├",
    collapsed = "─",
    expanded = "╮",
    failed = "✖",
    final_child_indent = " ",
    final_child_prefix = "╰",
    non_collapsible = "─",
    passed = "✔",
    running = "",
    skipped = "ﰸ",
    unknown = "?"
  },
})

  -- Test running (neotest)
vim.keymap.set('n', '<Leader>tn', neotest.run.run, { silent = true })
vim.keymap.set('n', '<Leader>tf', function()
  neotest.run.run(vim.fn.expand('%'))
end, { silent = true })
vim.keymap.set('n', '<Leader>to', function()
  neotest.output.open()
end, { silent = true })
vim.keymap.set('n', '<Leader>tt', function()
  neotest.summary.toggle()
end, { silent = true })
