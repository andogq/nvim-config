return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
        opts = {
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    },
                },
            },
        },
        config = function()
            pcall(require('telescope').load_extension, 'fzf')
        end,
        keys = function()
            local tb = require('telescope.builtin');

            return {
                {
                    '<leader>?',
                    tb.oldfiles,
                    desc = '[?] Find recently opened files',
                },
                {
                    '<leader><space>',
                    tb.buffers,
                    desc = '[ ] Find existing buffers'
                },
                {
                    '<leader>/',
                    function()
                        -- You can pass additional configuration to telescope to change theme, layout, etc.
                        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                            winblend = 10,
                            previewer = false,
                        })
                    end,
                    desc = '[/] Fuzzily search in current buffer'
                },
                {
                    '<leader>fG',
                    tb.git_files,
                    desc = '[F]ind [G]it files'
                },
                {
                    '<leader>ff',
                    tb.find_files,
                    desc = '[F]ind [F]iles'
                },
                {
                    '<leader>fh',
                    tb.help_tags,
                    desc = '[F]ind [H]elp'
                },
                {
                    '<leader>fw',
                    tb.grep_string,
                    desc = '[F]ind current [W]ord'
                },
                {
                    '<leader>fg',
                    tb.live_grep,
                    desc = '[F]ind by [g]rep'
                },
                {
                    '<leader>fd',
                    tb.diagnostics,
                    desc = '[F]ind [D]iagnostics'
                },
                {
                    '<leader>fr',
                    tb.resume,
                    desc = '[F]ind [R]esume'
                },
                {
                    '<leader>fm',
                    tb.marks,
                    desc = '[F]ind [M]arks',
                }
            }
        end,
    },
}
