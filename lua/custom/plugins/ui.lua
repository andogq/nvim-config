return {
    {
        'stevearc/dressing.nvim',
        opts = {},
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {},
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        init = function()
            require("lualine")
                .setup({
                    sections = {
                        lualine_x = {
                            {
                                require("noice").api.statusline.mode.get,
                                cond = require("noice").api.statusline.mode.has,
                                color = { fg = "#ff9e64" },
                            }
                        },
                    }
                })
        end
    }
}
