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
    {
        'kwkarlwang/bufresize.nvim',
        lazy = false,
        opts = {
            resize = {
                trigger_events = { "VimResized" },
            },
        },
        keys = function()
            local b = require("bufresize")

            local function wrap(cmd)
                return function()
                    vim.cmd(':' .. cmd)
                    b.register()
                end
            end

            return {
                {
                    '<leader>sv',
                    wrap('vsplit'),
                    desc = 'Create a split to the right',
                },
                {
                    '<leader>sh',
                    wrap('split'),
                    desc = 'Create a split below',
                },
                {
                    '<leader>sr',
                    wrap('vertical wincmd = | horizontal wincmd ='),
                    desc = 'Resize the panes to be equal',
                },
                {
                    '<leader>sx',
                    wrap('close'),
                    desc = 'Close the current pane',
                },

                -- Shortcut for split creation
                {
                    "<C-A-l>",
                    wrap("vsplit"),
                    desc = "Create a split to the right"
                },
                {
                    "<C-A-k>",
                    wrap("above split"),
                    desc = "Create a split above"
                },
                {
                    "<C-A-j>",
                    wrap("split"),
                    desc = "Create a split below"
                },
                {
                    "<C-A-h>",
                    wrap("leftabove vsplit"),
                    desc = "Create a split to the left"
                },
            }
        end
    }
}
