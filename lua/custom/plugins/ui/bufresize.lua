return {
  {
    'kwkarlwang/bufresize.nvim',
    opts = {
      resize = {
        trigger_events = { 'VimResized' },
      },
    },
    keys = function()
      local b = require 'bufresize'

      ---@param cmd string command to run
      local function wrap(cmd)
        return function()
          vim.cmd(':' .. cmd)
          b.register()
        end
      end

      return {
        {
          '<leader>sv',
          wrap 'vsplit',
          desc = 'Create a split to the right',
        },
        {
          '<leader>sh',
          wrap 'split',
          desc = 'Create a split below',
        },
        {
          '<leader>sr',
          wrap 'vertical wincmd = | horizontal wincmd =',
          desc = 'Resize the panes to be equal',
        },
        {
          '<leader>sx',
          wrap 'close',
          desc = 'Close the current pane',
        },

        -- Shortcut for split creation
        {
          '<C-A-l>',
          wrap 'vsplit',
          desc = 'Create a split to the right',
        },
        {
          '<C-A-k>',
          wrap 'above split',
          desc = 'Create a split above',
        },
        {
          '<C-A-j>',
          wrap 'split',
          desc = 'Create a split below',
        },
        {
          '<C-A-h>',
          wrap 'leftabove vsplit',
          desc = 'Create a split to the left',
        },
      }
    end,
  },
}
