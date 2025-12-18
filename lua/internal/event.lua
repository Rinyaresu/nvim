local api = vim.api
local au = api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('Group', {})

require('internal.test_runner').setup()

au('BufWritePre', {
  group = group,
  pattern = { '/tmp/*', 'COMMIT_EDITMSG', 'MERGE_MSG', '*.tmp', '*.bak' },
  command = 'setlocal noundofile',
})

au('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

au('BufEnter', {
  group = group,
  once = true,
  callback = function()
    require 'keymap'
  end,
  desc = 'Lazy load my keymap and buffer relate commands and default opt plugins',
})

local timer = nil --[[uv_timer_t]]
local function reset_timer()
  if timer then
    timer:stop()
    timer:close()
  end
  timer = nil
end

au('LspDetach', {
  callback = function(args)
    local client_id = args.data.client_id
    local client = vim.lsp.get_clients({ client_id = client_id })[1]
    if not client or not vim.tbl_isempty(client.attached_buffers) then
      return
    end
    reset_timer()
    timer = assert(vim.uv.new_timer())
    timer:start(200, 0, function()
      reset_timer()
      vim.schedule(function()
        vim.lsp.stop_client(client_id, true)
      end)
    end)
  end,
  desc = 'Auto stop client when no buffer atttached',
})
