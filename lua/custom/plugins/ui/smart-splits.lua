return {
  {
    'mrjones2014/smart-splits.nvim',
    dependencies = {
      'kwkarlwang/bufresize.nvim',
    },
    lazy = false,
    opts = {
      default_amount = 4,
      ignored_filetypes = { 'snacks_picker_list' },
    },
    keys = function()
      local ss = require 'smart-splits'

      local function wrap(resize)
        return function()
          -- Perform resize
          resize()

          -- Register current state
          require('bufresize').register()
        end
      end

      return {
        {
          '<A-h>',
          function()
            require('smart-splits').move_cursor_left()
          end,
          mode = { 'n', 'i', 'v' },
          desc = 'Select left buffer',
        },
        {
          '<A-j>',
          function()
            require('smart-splits').move_cursor_down()
          end,
          mode = { 'n', 'i', 'v' },
          desc = 'Select down buffer',
        },
        {
          '<A-k>',
          function()
            require('smart-splits').move_cursor_up()
          end,
          mode = { 'n', 'i', 'v' },
          desc = 'Select up buffer',
        },
        {
          '<A-l>',
          function()
            require('smart-splits').move_cursor_right()
          end,
          mode = { 'n', 'i', 'v' },
          desc = 'Select right buffer',
        },

        -- Shortcut for split resize
        {
          '<A-H>',
          wrap(ss.resize_left),
          desc = 'Resize buffer left',
        },
        {
          '<A-J>',
          wrap(ss.resize_down),
          desc = 'Resize buffer down',
        },
        {
          '<A-K>',
          wrap(ss.resize_up),
          desc = 'Resize buffer up',
        },
        {
          '<A-L>',
          wrap(ss.resize_right),
          desc = 'Resize buffer right',
        },
      }
    end,
  },
}
