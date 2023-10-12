return {
    {
        'mrjones2014/smart-splits.nvim',
        lazy = false,
        opts = {
            default_amount = 4,
            ignored_filetypes = { 'neo-tree' },
        },
        keys = function()
            local ss = require('smart-splits')

            return {
                {
                    '<A-h>',
                    ss.move_cursor_left,
                    desc = 'Select left buffer',
                },
                {
                    '<A-j>',
                    ss.move_cursor_down,
                    desc = 'Select down buffer',
                },
                {
                    '<A-k>',
                    ss.move_cursor_up,
                    desc = 'Select up buffer',
                },
                {
                    '<A-l>',
                    ss.move_cursor_right,
                    desc = 'Select right buffer',
                },
                {
                    '<A-H>',
                    ss.resize_left,
                    desc = 'Resize buffer left',
                },
                {
                    '<A-J>',
                    ss.resize_down,
                    desc = 'Resize buffer down',
                },
                {
                    '<A-K>',
                    ss.resize_up,
                    desc = 'Resize buffer up',
                },
                {
                    '<A-L>',
                    ss.resize_right,
                    desc = 'Resize buffer right',
                },
            }
        end,
    },
}
