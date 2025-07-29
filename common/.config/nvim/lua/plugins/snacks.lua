return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = { enabled = true, example = 'advanced' },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    scroll = { enabled = true },
    scratch = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
    lazygit = { enabled = true },
    terminal = {
      enabled = true,
      bo = {
        filetype = 'snacks_terminal',
      },
      wo = {},
      keys = {
        q = 'hide',
        gf = function(self)
          local f = vim.fn.findfile(vim.fn.expand('<cfile>'), '**')
          if f == '' then
            Snacks.notify.warn('No file under cursor')
          else
            self:hide()
            vim.schedule(function()
              vim.cmd('e ' .. f)
            end)
          end
        end,
        term_normal = {
          '<esc>',
          function(self)
            self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
            if self.esc_timer:is_active() then
              self.esc_timer:stop()
              vim.cmd('stopinsert')
            else
              self.esc_timer:start(200, 0, function() end)
              return '<esc>'
            end
          end,
          mode = 't',
          expr = true,
          desc = 'Double escape to normal mode',
        },
      },
    },
  },
  keys = {
    { '<leader>:',  function() Snacks.picker.command_history() end,                         desc = 'Command History' },
    -- find
    { '<leader>fb', function() Snacks.picker.buffers() end,                                 desc = 'Buffers' },
    { '<leader>fc', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end, desc = 'Find Config File' },
    { '<leader>ff', function() Snacks.picker.files({ hidden = true }) end,                  desc = 'Find Files' },
    { '<leader>fg', function() Snacks.picker.git_files() end,                               desc = 'Find Git Files' },
    { '<leader>fr', function() Snacks.picker.recent() end,                                  desc = 'Recent' },
    -- git
    { '<leader>gc', function() Snacks.picker.git_log() end,                                 desc = 'Git Log' },
    { '<leader>gs', function() Snacks.picker.git_status() end,                              desc = 'Git Status' },
    -- Grep
    { '<leader>sb', function() Snacks.picker.lines() end,                                   desc = 'Buffer Lines' },
    { '<leader>sB', function() Snacks.picker.grep_buffers() end,                            desc = 'Grep Open Buffers' },
    { '<leader>sg', function() Snacks.picker.grep({ hidden = true }) end,                                    desc = 'Grep' },
    { '<leader>sw', function() Snacks.picker.grep_word({ hidden = true }) end,                               desc = 'Visual selection or word', mode = { 'n', 'x' } },
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end,                               desc = 'Registers' },
    { '<leader>sa', function() Snacks.picker.autocmds() end,                                desc = 'Autocmds' },
    { '<leader>sc', function() Snacks.picker.command_history() end,                         desc = 'Command History' },
    { '<leader>sC', function() Snacks.picker.commands() end,                                desc = 'Commands' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end,                             desc = 'Diagnostics' },
    { '<leader>sh', function() Snacks.picker.help() end,                                    desc = 'Help Pages' },
    { '<leader>sH', function() Snacks.picker.highlights() end,                              desc = 'Highlights' },
    { '<leader>sj', function() Snacks.picker.jumps() end,                                   desc = 'Jumps' },
    { '<leader>sk', function() Snacks.picker.keymaps() end,                                 desc = 'Keymaps' },
    { '<leader>sl', function() Snacks.picker.loclist() end,                                 desc = 'Location List' },
    { '<leader>sM', function() Snacks.picker.man() end,                                     desc = 'Man Pages' },
    { '<leader>sm', function() Snacks.picker.marks() end,                                   desc = 'Marks' },
    { '<leader>sR', function() Snacks.picker.resume() end,                                  desc = 'Resume' },
    { '<leader>sq', function() Snacks.picker.qflist() end,                                  desc = 'Quickfix List' },
    { '<leader>uC', function() Snacks.picker.colorschemes() end,                            desc = 'Colorschemes' },
    { '<leader>qp', function() Snacks.picker.projects() end,                                desc = 'Projects' },
    -- LSP
    { 'gd',         function() Snacks.picker.lsp_definitions() end,                         desc = 'Goto Definition' },
    { 'gr',         function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = 'References' },
    { 'gI',         function() Snacks.picker.lsp_implementations() end,                     desc = 'Goto Implementation' },
    { 'gy',         function() Snacks.picker.lsp_type_definitions() end,                    desc = 'Goto T[y]pe Definition' },
    { '<leader>ss', function() Snacks.picker.lsp_symbols() end,                             desc = 'LSP Symbols' },
    -- Others
    { '<leader>z',  function() Snacks.zen() end,                                            desc = 'Zen Mode' },
    { '<leader>lg', function() Snacks.lazygit() end,                                        desc = 'LazyGit' },
    { '<leader>sc', function() Snacks.scratch() end,                                        desc = 'Scratch' },
    { '<leader>t',  function() Snacks.terminal() end,                                       desc = 'Terminal' },
  },
}
