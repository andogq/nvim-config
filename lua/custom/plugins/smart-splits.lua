return {
  {
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    opts = {
      default_amount = 4,
      ignored_filetypes = { 'neo-tree' },
    },
    keys = {
      {
        '<A-h>',
        function()
          require('smart-splits').move_cursor_left()
        end,
        desc = 'Select left buffer',
      },
      {
        '<A-j>',
        function()
          require('smart-splits').move_cursor_down()
        end,
        desc = 'Select down buffer',
      },
      {
        '<A-k>',
        function()
          require('smart-splits').move_cursor_up()
        end,
        desc = 'Select up buffer',
      },
      {
        '<A-l>',
        function()
          require('smart-splits').move_cursor_right()
        end,
        desc = 'Select right buffer',
      },
    },
  },
}
