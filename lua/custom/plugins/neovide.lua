if vim.g.neovide then
    vim.o.guifont = "FiraCode Nerd Font:h11"

    -- Removes weird gap between some lines
    vim.opt.linespace = -1

    -- vim.g.neovide_theme = "auto"

    vim.g.neovide_refresh_rate = 120
    vim.g.neovide_refresh_rate_idle = 5
    vim.g.neovide_no_idle = false

    local padding = 11
    vim.g.neovide_padding_top = padding
    vim.g.neovide_padding_bottom = padding
    vim.g.neovide_padding_right = padding
    vim.g.neovide_padding_left = padding

    -- Treat option key as meta
    vim.g.neovide_input_macos_option_key_is_meta = "both"

    -- Allow copy/paste with Cmd-C/Cmd-V
    vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
    vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
    vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
    vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
    vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

    -- Scaling
    vim.g.neovide_scale_factor = 1.0
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    -- Reset zoom
    vim.keymap.set("n", "<D-0>", function()
        vim.g.neovide_scale_factor = 1.0
    end)
    -- Zoom in
    vim.keymap.set("n", "<D-+>", function()
        change_scale_factor(1.25)
    end)
    -- Zoom out
    vim.keymap.set("n", "<D-->", function()
        change_scale_factor(1 / 1.25)
    end)
end

return {}
