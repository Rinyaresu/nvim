return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<C-f>', function()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<leader>h', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set('n', '<C-A-h>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<C-A-j>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<C-A-k>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<C-A-l>', function()
        harpoon:list():select(4)
      end)
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
