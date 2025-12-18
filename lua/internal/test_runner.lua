local M = {}

local window_name = 'run-tests'

local function is_ruby_spec(path)
  return path:match('_spec%.rb$') ~= nil
end

local function is_js_spec(path)
  return path:match('%.spec%.jsx$') ~= nil
end

local function collect_open_test_files()
  local ruby_files = {}
  local js_files = {}
  local seen = {}

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and vim.bo[buf].buftype == '' then
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= '' and not seen[name] then
        seen[name] = true
        if is_ruby_spec(name) then
          table.insert(ruby_files, name)
        elseif is_js_spec(name) then
          table.insert(js_files, name)
        end
      end
    end
  end

  table.sort(ruby_files)
  table.sort(js_files)

  return ruby_files, js_files
end

local function shell_escape_files(files)
  local escaped = {}
  for _, file in ipairs(files) do
    escaped[#escaped + 1] = vim.fn.shellescape(file)
  end
  return table.concat(escaped, ' ')
end

local function build_command(ruby_files, js_files)
  local commands = {}

  if #ruby_files > 0 then
    commands[#commands + 1] = 'bundle exec rspec ' .. shell_escape_files(ruby_files)
  end

  if #js_files > 0 then
    commands[#commands + 1] = 'yarn test -- ' .. shell_escape_files(js_files)
  end

  return table.concat(commands, ' ; ')
end

local function run_in_tmux(command)
  if command == '' then
    return
  end

  if not vim.env.TMUX or vim.env.TMUX == '' then
    vim.notify('TMUX not detected. Start Neovim inside tmux to use :RunOpenTests.', vim.log.levels.WARN)
    return
  end

  local cwd = vim.fn.getcwd()
  local shell = 'bash'
  local wait_command = "printf '\\n[run-tests] Press any key to close...'; read -n 1 -s -r"
  if vim.fn.executable(shell) ~= 1 then
    shell = vim.env.SHELL or '/bin/sh'
    if vim.fn.executable(shell) ~= 1 then
      shell = '/bin/sh'
    end
    wait_command = "printf '\\n[run-tests] Press Enter to close...'; read -r"
  end

  local command_with_wait = command .. '; ' .. wait_command

  vim.system({ 'tmux', 'new-window', '-n', window_name, '-c', cwd, shell, '-lc', command_with_wait }, { text = true }, function(result)
    if result.code == 0 then
      return
    end

    vim.schedule(function()
      vim.notify('Failed to open tmux window for tests.', vim.log.levels.ERROR)
    end)
  end)
end

function M.run_open_tests()
  local ruby_files, js_files = collect_open_test_files()

  if #ruby_files == 0 and #js_files == 0 then
    vim.notify('No open test buffers found for _spec.rb or .spec.jsx.', vim.log.levels.INFO)
    return
  end

  local command = build_command(ruby_files, js_files)
  run_in_tmux(command)
end

function M.setup()
  vim.api.nvim_create_user_command('RunOpenTests', function()
    M.run_open_tests()
  end, {})
end

return M
