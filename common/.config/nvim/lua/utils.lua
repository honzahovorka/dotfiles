local function resolve_git_relative_path(buffer_path)
  if buffer_path == '' then
    return nil
  end

  local search_path = vim.fs.dirname(buffer_path)
  if vim.fn.executable('git') == 1 then
    local prefix = vim.fn.systemlist({ 'git', '-C', search_path, 'rev-parse', '--show-prefix' })[1]
    if vim.v.shell_error == 0 and prefix then
      local filename = vim.fn.fnamemodify(buffer_path, ':t')
      return prefix .. filename
    end
  end

  return vim.loop.fs_realpath(buffer_path) or buffer_path
end

function _G.yank_current_path()
  local buffer_path = vim.api.nvim_buf_get_name(0)
  if buffer_path == '' then
    vim.notify('No file path for current buffer.', vim.log.levels.WARN)
    return
  end

  local final_path = resolve_git_relative_path(buffer_path)
  vim.fn.setreg('+', final_path)
  vim.notify(('Yanked path: %s'):format(final_path), vim.log.levels.INFO)
end
