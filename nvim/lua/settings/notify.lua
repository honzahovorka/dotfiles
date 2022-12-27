local notify = require('notify')

notify.setup({
  stages = 'fade',
  timeout = 3000,
})

vim.cmd([[
  augroup config_notify
  autocmd!
  autocmd ColorScheme * hi! link NotifyINFOIcon String
  autocmd ColorScheme * hi! link NotifyINFOTitle String
  augroup END
]])
