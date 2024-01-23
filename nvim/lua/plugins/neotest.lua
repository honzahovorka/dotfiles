return {
  'nvim-neotest/neotest',
  dependencies = { 'haydenmeade/neotest-jest' },
  config = function()
    local neotest = require('neotest')
    neotest.setup({
      adapters = {
        require('neotest-jest')({
          jestCommand = 'npx jest',
          jestConfigFile = 'jest.json',
          jest_test_discovery = true,
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
      },
      discovery = {
        enabled = false,
      },
    })

    vim.keymap.set('n', '<Leader>tn',neotest.run.run)
    vim.keymap.set('n', '<Leader>tf', function()
      neotest.run.run(vim.fn.expand('%'))
    end)
    vim.keymap.set('n', '<Leader>to', function()
      neotest.output.open()
    end)
    vim.keymap.set('n', '<Leader>tp', function()
      neotest.output_panel.toggle()
    end)
    vim.keymap.set('n', '<Leader>tt', function()
      neotest.summary.toggle()
    end)
  end
}
