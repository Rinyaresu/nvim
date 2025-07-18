local M = {}

function M.codecompanion()
  require('codecompanion').setup {
    strategies = {
      chat = {
        slash_commands = {
          ['file'] = {
            callback = 'strategies.chat.slash_commands.file',
            description = 'Select a file',
            opts = {
              contains_code = true,
              provider = 'snacks',
              default_params = 'watch',
            },
          },
          ['buffer'] = {
            callback = 'strategies.chat.slash_commands.buffer',
            description = 'Insert open buffers',
            opts = {
              contains_code = true,
              default_params = 'watch',
              provider = 'snacks',
            },
          },
        },
        adapter = 'copilot',
      },
      inline = { adapter = 'copilot' },
    },
    opts = {
      log_level = 'DEBUG',
    },
    display = {
      provider = 'snacks',
      action_palette = {
        width = 95,
        height = 10,
        prompt = 'Prompt ',
        provider = 'snacks', -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
        opts = {
          show_default_actions = true,
          show_default_prompt_library = true,
        },
      },
    },
  }
end

function M.copilot()
  require('copilot').setup {
    suggestion = { enabled = false },
    panel = { enabled = false },
    copilot_node_command = vim.fn.expand '$HOME' .. '/.asdf/installs/nodejs/23.10.0/bin/node',
  }
end

return M
