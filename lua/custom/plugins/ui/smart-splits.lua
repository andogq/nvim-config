return {
  {
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    opts = {
      default_amount = 4,
      ignored_filetypes = { 'snacks_picker_list' },
    },
    keys = {
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
    },
  },
}
