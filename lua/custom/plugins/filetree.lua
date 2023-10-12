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
        config = function ()
            require("neo-tree").setup({})

            vim.keymap.set('n', '\\', function ()
                require('neo-tree.command').execute({ reveal = true, toggle = true })
            end, { desc = 'Toggle file tree at current file' })

            vim.keymap.set('n', '<leader>lf', function ()
                require('neo-tree.command').execute({ reveal = true })
            end, { desc = '[L]ist [f]iles in Neotree' })

            vim.keymap.set('n', '<leader>lg', function ()
                require('neo-tree.command').execute({ reveal = true, source = 'git_status' })
            end, { desc = '[L]ist [G]it changes in Neotree' })
        end
    },
}
