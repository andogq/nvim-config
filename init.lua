-- Install core plugins
vim.pack.add({
    "https://github.com/folke/tokyonight.nvim", -- Color scheme
    "https://github.com/nvim-mini/mini.nvim", --  Utilities
})

-- Define config table for utilities
_G.Config = {}

-- Helpers
local group = vim.api.nvim_create_augroup("custom-config", {})
Config.new_autocmd = function(event, pattern, callback, desc)
    vim.api.nvim_create_autocmd(event, {
        group = group,
        pattern = pattern,
        callback = callback,
        desc = desc,
    })
end

local misc = require("mini.misc")
Config.now = function(f) misc.safely("now", f) end
Config.later = function(f) misc.safely("later", f) end
Config.on_event = function(ev, f) misc.safely("event:" .. ev, f) end
Config.on_filetype = function(ft, f) misc.safely("filetype:" .. ft, f) end

Config.on_package_change = function(plugin_name, kinds, callback, desc)
    Config.new_autocmd("PackChanged", "*", function(ev)
        local name = ev.data.spec.name
        local kind = ev.data.kind
        if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
        if not ev.data.active then vim.cmd.packadd(plugin_name) end
        callback()
    end, desc)
end
