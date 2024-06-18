return {
  {
    'zbirenbaum/copilot.lua',
    lazy = true,
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        cmp = {
          enabled = true,
          method = 'getCompletionsCycling',
        },
        panel = {
          enabled = false,
        },
        suggestion = {
          enabled = false,
        },
      }
    end,
    dependencies = {
      {
        'zbirenbaum/copilot-cmp',
        config = function()
          require('copilot_cmp').setup()
        end,
      },
    },
  },
}
