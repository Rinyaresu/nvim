local M = {}

function M.add_debugger()
  local buftype = vim.bo.filetype

  if buftype == 'ruby' then
    vim.cmd('norm O' .. 'binding.pry', false)
  elseif buftype == 'eruby' then
    vim.cmd('norm O<% ' .. 'binding.pry' .. ' %>', false)
  elseif buftype == 'javascript' or buftype == 'javascriptreact' or buftype == 'typescript' or buftype == 'typescriptreact' then
    vim.cmd('norm 0"dy', false)
    vim.cmd("norm! Oconsole.info('DEBUGGER', '" .. "', );", false)
  end
end

function M.clear_debugger()
  local buftype = vim.bo.filetype

  if buftype == 'ruby' then
    vim.cmd('%s/.*' .. 'binding.pry' .. '\\n//g', true)
  elseif buftype == 'javascript' or buftype == 'javascriptreact' or buftype == 'typescript' or buftype == 'typescriptreact' then
    vim.cmd('%s/.*console.info(\\_.\\{-\\});\\n//g', true)
    vim.cmd('%s/.*console.log(\\_.\\{-\\});\\n//g', true)
  elseif buftype == 'eruby' then
    vim.cmd('%s/.*<% ' .. 'binding.pry' .. ' %>\\n//g', true)
  end
  vim.api.nvim_command 'write'
end

function M.setreg(regname, regval)
  vim.fn.setreg(regname, regval)
end

function M.copy_path()
  local file = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
  local line = vim.fn.line '.'
  local value = file .. ':' .. line

  M.setreg('*', value)
  M.setreg('+', value)
  print('Yanked: ' .. value)
end

function M.find_in_folder(folder, title)
  return function()
    if vim.fn.isdirectory(folder) == 1 then
      vim.cmd("lua require'telescope.builtin'.find_files({ cwd = '" .. folder .. "', prompt_title = '" .. title .. "' })")
    else
      print("Directory: '" .. folder .. "' not found in this project...")
    end
  end
end

function M.replace_in_quickfix()
  local query = vim.fn.input 'Enter search string: '
  if query == '' then
    print 'Search string cannot be empty.'
    return
  end
  local replacement = vim.fn.input 'Enter replacement string: '
  vim.cmd(string.format('cdo s/%s/%s/gc', query, replacement))
end

function M.find_and_replace()
  local search = vim.fn.input 'Find: '
  if search == '' then
    print 'Search string cannot be empty.'
    return
  end
  local replace = vim.fn.input 'Replace: '
  vim.cmd('%s/' .. search .. '/' .. replace .. '/g')
end

return M
