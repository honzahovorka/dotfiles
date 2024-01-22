return {
  'mfussenegger/nvim-dap',
  event = 'VeryLazy',
  dependencies = {
    {
      { 'rcarriga/nvim-dap-ui' },
      { 'mxsdev/nvim-dap-vscode-js' },
      {
        'microsoft/vscode-js-debug',
        build = 'rm -rf out/dist && npm ci && npm run compile vsDebugServerBundle && mv dist out',
      },
      { 'theHamsta/nvim-dap-virtual-text' },
      { 'nvim-telescope/telescope-dap.nvim' },
    },
  },
  config = function()
    local dapui = require('dapui')
    local dap = require('dap')

    dapui.setup()

    -- Set keymaps to control the debugger
    vim.keymap.set('n', '<leader>dc', dap.continue)
    vim.keymap.set('n', '<leader>do', dap.step_over)
    vim.keymap.set('n', '<leader>di', dap.step_into)
    vim.keymap.set('n', '<leader>dt', dap.step_out)
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end)
    vim.keymap.set('n', '<leader>dr', dap.repl.open)
    vim.keymap.set('n', '<leader>du', dapui.toggle)

    require('dap-vscode-js').setup({
      debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
    })

    for _, language in ipairs({ 'typescript', 'javascript' }) do
      require('dap').configurations[language] = {
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach existing process',
          resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
          cwd = '${workspaceFolder}',
          skipFiles = { '<node_internals>/**', '${workspaceFolder}/node_modules/**' },
        },
      }
    end

    vim.fn.sign_define('DapBreakpoint', { text = '⬤', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DapStopped', linehl = '', numhl = '' })

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open { reset = true }
    end
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
