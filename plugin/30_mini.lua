-- Pre-requisite plugins ======================================================
Config.now(function()
    require("mini.icons").setup()
    Config.later(MiniIcons.mock_nvim_web_devicons)
    Config.later(MiniIcons.tweak_lsp_kind)
end)

Config.now(function()
    require("mini.misc").setup()
    MiniMisc.setup_auto_root()
    MiniMisc.setup_restore_cursor()
    MiniMisc.setup_termbg_sync()
end)

Config.now(function() require("mini.notify").setup() end)

-- Completion
Config.now(
    function()
        require("mini.completion").setup({
            delay = {
                completion = 100,
                info = 100,
                signature = 0,
            },
        })
    end
)

Config.now(function()
    local snippets = require("mini.snippets")
    snippets.setup({
        snippets = {
            snippets.gen_loader.from_lang(),
        },
    })
end)

-- Other plugins
Config.now(function()
    local miniclue = require("mini.clue")
    miniclue.setup({
        triggers = {
            -- Leader triggers
            { mode = { "n", "x" }, keys = "<Leader>" },

            -- `[` and `]` keys
            { mode = "n", keys = "[" },
            { mode = "n", keys = "]" },

            -- Built-in completion
            { mode = "i", keys = "<C-x>" },

            -- `g` key
            { mode = { "n", "x" }, keys = "g" },

            -- Marks
            { mode = { "n", "x" }, keys = "'" },
            { mode = { "n", "x" }, keys = "`" },

            -- Registers
            { mode = { "n", "x" }, keys = '"' },
            { mode = { "i", "c" }, keys = "<C-r>" },

            -- Window commands
            { mode = "n", keys = "<C-w>" },

            -- `z` key
            { mode = { "n", "x" }, keys = "z" },
        },

        clues = {
            Config.leader_group_clues,
            miniclue.gen_clues.square_brackets(),
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            miniclue.gen_clues.windows(),
            miniclue.gen_clues.z(),
        },

        window = {
            delay = 500,
        },
    })
end)

Config.now(function() require("mini.extra").setup() end)

Config.now(function()
    require("mini.sessions").setup({
        autoread = true,
        autowrite = false,
        file = "", -- Disable local session files
    })
end)

-- Editor =====================================================================
Config.later(function() require("mini.ai").setup() end)

Config.later(function() require("mini.bracketed").setup() end)

Config.later(function() require("mini.bufremove").setup() end)

Config.later(
    function()
        require("mini.diff").setup({
            view = {
                style = "sign",
            },
            options = {
                wrap_goto = true,
            },
        })
    end
)

Config.later(function() require("mini.git").setup() end)

Config.later(function() require("mini.jump").setup() end)

Config.later(function() require("mini.pairs").setup() end)

-- UI =========================================================================
Config.later(function() require("mini.cmdline").setup() end)

Config.later(function() require("mini.cursorword").setup() end)

Config.later(
    function()
        require("mini.files").setup({
            windows = {
                preview = true,
            },
        })
    end
)

Config.later(function()
    local hipatterns = require("mini.hipatterns")
    hipatterns.setup({
        highlighters = {
            -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
            fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
            hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
            todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
            note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

            -- Highlight hex color strings (`#rrggbb`) using that color
            hex_color = hipatterns.gen_highlighter.hex_color(),
        },
    })
end)

Config.later(function()
    require("mini.indentscope").setup({
        symbol = "│",
    })
end)

Config.later(function()
    require("mini.pick").setup()

    MiniPick.registry.projects = function()
        -- Find all git repositories within ~/code (limiting search to 2 nested directories)
        local find_cmd = {
            "find",
            vim.fn.expand("~/code"),
            "-maxdepth",
            "2",
            "-type",
            "d",
            "-exec",
            "test",
            "-e",
            "{}/.git",
            ";",
            "-print",
            "-prune",
        }
        local items = vim.schedule_wrap(function() MiniPick.set_picker_items_from_cli(find_cmd) end)
        return MiniPick.start({ source = { items = items, name = "Projects" } })
    end
end)

Config.later(function() require("mini.statusline").setup() end)
