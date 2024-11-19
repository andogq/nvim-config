-- Disable legacy v1.0 commands
-- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            {
                '\\',
                function()
                    require('neo-tree.command').execute({ reveal = true, toggle = true })
                end,
                desc = 'Toggle file tree at current file'
            },
            {
                '<leader>lf',
                function()
                    require('neo-tree.command').execute({ reveal = true })
                end,
                desc = '[L]ist [f]iles in Neotree',
            },
            {
                '<leader>lg',
                function()
                    require('neo-tree.command').execute({ reveal = true, source = 'git_status' })
                end,
                desc = '[L]ist [g]it changes in Neotree',
            },
        },
        opts = {
            git_status_async = true,
            follow_current_file = {
                enabled = true,
            },
            filesystem = {
                bind_to_cwd = true,    -- true creates a 2-way binding between vim's cwd and neo-tree's root
                cwd_target = {
                    sidebar = "tab",   -- sidebar is when position = left or right
                    current = "window" -- current is when position = current
                },
                use_libuv_file_watcher = true,
                hijack_netrw_behavior = "open_current",
            }
        }
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        keys = {
            {
                "-",
                desc = "Open parent directory in oil.nvim",
                "<cmd>Oil<cr>",
            }
        }
    }
}
