return {
    {
        'stevearc/dressing.nvim',
        opts = {},
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                }
            },
            presets = {
                bottom_search = true,
                command_palette = true,
            }
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        init = function()
            require("telescope").load_extension("noice")

            require("lualine")
                .setup({
                    sections = {
                        lualine_x = {
                            {
                                require("noice").api.status.message.get_hl,
                                cond = require("noice").api.status.message.has,
                            },
                            {
                                require("noice").api.status.command.get,
                                cond = require("noice").api.status.command.has,
                                color = { fg = "#ff9e64" },
                            },
                            {
                                require("noice").api.status.mode.get,
                                cond = require("noice").api.status.mode.has,
                                color = { fg = "#ff9e64" },
                            },
                            {
                                require("noice").api.status.search.get,
                                cond = require("noice").api.status.search.has,
                                color = { fg = "#ff9e64" },
                            },
                        },
                    },
                })
        end,
        keys = {
            {
                "<leader>fn",
                desc = "[F]ind [N]otifications",
                function() require("telescope").extensions.noice.noice() end
            }
        }

    },
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        lazy = false,
        opts = function(_config, opts)
            return vim.tbl_extend("force", opts, {
                options = {
                    offsets = {
                        { -- Dodge neotree
                            filetype = "neo-tree",
                            separator = true,
                        }
                    },
                    groups = {
                        items = {
                            require('bufferline.groups').builtin.pinned:with({ icon = "󰐃 " })
                        }
                    }
                }
            })
        end,
        keys = {
            {
                "<leader>bg",
                desc = "Goto Buffer",
                "<cmd>BufferLinePick<cr>"
            },
            {
                "<leader>bc",
                desc = "Close Buffer",
                "<cmd>BufferLinePickClose<cr>"
            },
            {
                "<leader>bt",
                desc = "Rename Tab",
                function()
                    local tab_name = vim.fn.input("New tab name: ")
                    vim.cmd("BufferLineTabRename " .. tab_name)
                end
            },
            {
                "<leader>bp",
                desc = "Pin Buffer",
                "<cmd>BufferLineTogglePin<cr>"
            }
        }
    }
}
