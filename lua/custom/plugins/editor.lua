return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {},
    },
    {
        'chentoast/marks.nvim',
        opts = {},
    },
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {},
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            {
                "S",
                mode = { "n", "x", "o" },
                function() require("flash").treesitter() end,
                desc =
                "Flash Treesitter"
            },
            {
                "r",
                mode = "o",
                function() require("flash").remote() end,
                desc =
                "Remote Flash"
            },
            {
                "R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc =
                "Treesitter Search"
            },
            {
                "<c-s>",
                mode = { "c" },
                function() require("flash").toggle() end,
                desc =
                "Toggle Flash Search"
            },
        }
    },
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            icons = true,
            use_lsp_diagnostic_signs = false,
        },
        keys = {
            {
                "<leader>xx",
                function() require("trouble").toggle() end
            },
            {
                "<leader>xw",
                function() require("trouble").toggle("workspace_diagnostics") end
            },
            {
                "<leader>xd",
                function() require("trouble").toggle("document_diagnostics") end
            },
            {
                "<leader>xq",
                function() require("trouble").toggle("quickfix") end
            },
            {
                "<leader>xl",
                function() require("trouble").toggle("loclist") end
            },
        },
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { "nvim-lua/plenary.nvim" },
        -- cmd = { "TodoTrouble", "TodoTelescope" },
        -- config = true,
        opts = {},
        -- keys = {
        --     { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
        --     { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
        --     { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
        --     { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
        --     { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
        --     { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
        -- }
    },
    {
        'IndianBoy42/tree-sitter-just',
        config = function()
            require('nvim-treesitter.install').compilers = { 'gcc-11' }
            require('tree-sitter-just').setup({})
        end
    },
    {
        'folke/zen-mode.nvim',
        opts = {
            options = {
                signcolumn = "yes",
                relativenumber = true,
                cursorline = true,
            }
        },
        keys = {
            { '<leader>z', function() require('zen-mode').toggle() end },
        },
    },
    {
        'Aasim-A/scrollEOF.nvim',
        event = { 'CursorMoved', 'WinScrolled' },
        opts = {}
    },
    {
        'stevearc/conform.nvim',
        opts = {
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
            formatters_by_ft = {
                javascript = { "prettierd", },
                javascriptreact = { "prettierd", },
                python = { "ruff" },
                typescript = { "prettierd", },
                typescriptreact = { "prettierd", },
            },
        },
    },
    {
        'mfussenegger/nvim-lint',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                javascript = { "eslint" },
                javascriptreact = { "eslint" },
                python = { "ruff", "flake8" },
                typescript = { "eslint" },
                typescriptreact = { "eslint" },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    }
}
