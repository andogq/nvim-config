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

    {
        "ahmedkhalf/project.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim"
        },
        main = "project_nvim",
        opts = {
            -- Manual mode doesn't automatically change your root directory, so you have
            -- the option to manually do so using `:ProjectRoot` command.
            manual_mode = false,

            -- Methods of detecting the root directory. **"lsp"** uses the native neovim
            -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
            -- order matters: if one is not detected, the other is used as fallback. You
            -- can also delete or rearangne the detection methods.
            detection_methods = { "lsp", "pattern" },

            -- All the patterns used to detect root dir, when **"pattern"** is in
            -- detection_methods
            patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

            -- Table of lsp clients to ignore by name
            -- eg: { "efm", ... }
            ignore_lsp = {},

            -- Don't calculate root dir on specific directories
            -- Ex: { "~/.cargo/*", ... }
            exclude_dirs = {},

            -- Show hidden files in telescope
            show_hidden = false,

            -- When set to false, you will get a message when project.nvim changes your
            -- directory.
            silent_chdir = true,

            -- What scope to change the directory, valid options are
            -- * global (default)
            -- * tab
            -- * win
            scope_chdir = 'tab',

            -- Path where project.nvim will store the project history for use in
            -- telescope
            datapath = vim.fn.stdpath("data"),
        },
        init = function()
            -- Register the extension with telescope
            require('telescope').load_extension('projects')
        end,
        keys = {
            {
                '<leader>fp',
                desc = "[F]ind [P]rojects",
                function()
                    require("telescope").extensions.projects.projects({})
                end,
            }
        }
    }
}
