local default_header = {
    type = "text",
    val = {
        [[                                  __]],
        [[     ___     ___    ___   __  __ /\_\    ___ ___]],
        [[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
        [[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
        [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    },
    opts = {
        hl = "Type",
        shrink_margin = false,
        position = "center"
    },
}

return {
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = function()
            local icon = function(fn)
                --- @param fn string: File name
                local nwd = require('nvim-web-devicons')

                -- Extract the extension from the file name
                local match = fn:match("^.+(%..+)$")

                ---@type string
                local ext = ""
                if match ~= nil then
                    ext = match:sub(2)
                end

                return nwd.get_icon(fn, ext, { default = true })
            end

            return {
                layout = {
                    { type = "padding", val = 1 },
                    default_header,
                    { type = "padding", val = 2 },

                },
                opts = {
                    margin = 3,
                    redraw_on_resize = false,
                    setup = function()
                        vim.api.nvim_create_autocmd("DirChanged", {
                            pattern = "*",
                            group = "alpha_temp",
                            callback = function() require("alpha").redraw() end,
                        })
                    end
                }
            }
        end
    },
    {
        'folke/persistence.nvim',
        event = 'BufReadPre',
        opts = {}
    }
}
