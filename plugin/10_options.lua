-- General ====================================================================
vim.g.mapleader = " "

vim.o.mouse = "a" -- Enable mouse
vim.o.switchbuf = "usetab" -- Reuse already opened buffers
vim.o.undofile = true -- Persistent undo

-- Limit ShaDa file (for startup)
vim.opt.shada = { "'100", "<50", "s10", ":1000", "/100", "@100", "h" }

-- Enable syntax and filetype plugins
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

-- UI =========================================================================
vim.cmd("colorscheme tokyonight") -- Configure colorscheme

vim.o.completetimeout = 100 -- Limit timeout for completion
vim.o.list = true -- Show text indicators
vim.o.number = true -- Show line numbers
vim.o.pumborder = "bold" -- Use border for popup menu
vim.o.pumheight = 10 -- Make popup menu smaller
vim.o.pummaxwidth = 100 -- Limit width of popup menu
vim.o.relativenumber = true -- Use relative line numbers
vim.o.ruler = false -- Don't show cursor coordinates
vim.o.scrolloff = 10 -- Allow to scroll beyond end of file
vim.o.shortmess = "CFOSWaco" -- Disable some messages
vim.o.showmode = false -- Don't show current mode
vim.o.signcolumn = "yes" -- Always show sign column
vim.o.termguicolors = true -- Use 24-bit color
vim.o.winborder = "bold" -- Show border on floating windows

-- Line break configuration
vim.o.breakindent = true -- Indent wrapped lines
vim.opt.breakindentopt = { list = "-1" } -- Add padding for list items
vim.o.colorcolumn = "0" -- Draw column on maximum width
vim.o.linebreak = true -- Wrap lines at 'breakat'
vim.o.wrap = false -- Don't visually wrap lines

-- Split configuration
vim.o.splitbelow = true -- Horizontal splits below
vim.o.splitkeep = "screen" -- Keep the cursor at the same position split
vim.o.splitright = true -- Vertical splits right

-- Cursor line configuration
vim.o.cursorline = true -- Highlight current line
vim.opt.cursorlineopt = { "screenline", "number" } -- Show cursor line per screen line

-- UI symbols
vim.opt.fillchars = {
    eob = " ",
    fold = "╌",
}
vim.opt.listchars = {
    extends = "…",
    nbsp = "␣",
    precedes = "…",
    trail = "·",
    tab = "» ",
}

-- Folds
vim.o.foldlevel = 1 -- Fold everything except top level
vim.o.foldmethod = "indent" -- Fold based on indent level
vim.o.foldnestmax = 10 -- Limit number of fold levels
vim.o.foldtext = "" -- Show text under fold

-- Enable UI2
-- require("vim._core.ui2").enable({ enable = true })

-- Editing ===================================================================
vim.o.formatoptions = "rqnl1j" -- Improve comment editing
vim.o.infercase = true -- Infer case in built-in completion
vim.o.virtualedit = "block" -- Allow cursor to go beyond line in block mode

-- Indenting
local tab_width = 4
vim.o.autoindent = true -- Use auto indent
vim.o.expandtab = true -- Convert tabs to spaces
vim.opt.iskeyword = { -- ASCII characters to consider as part of a word
    "@",
    "48-57",
    "_",
    "192-255",
    "-",
}
vim.o.shiftwidth = tab_width -- Number of spaces for indentation
vim.o.smartindent = true -- Smart indenting
vim.o.tabstop = tab_width -- Show tab as spaces

-- Searching
vim.o.ignorecase = true -- Ignore case in search
vim.o.incsearch = true -- Show matches while typing
vim.o.smartcase = true -- Respect case is search pattern has upper case

-- Spell check
vim.opt.spelllang = { "en", "uk" } -- Dictionaries
vim.o.spelloptions = "camel" -- Spell check camelCase words

-- Pattern for a start of 'numbered' list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- Completion
vim.opt.complete = { -- Completion sources
    ".", -- Current buffer
    "w", -- Buffers in other windows
    "b", -- Loaded buffers
    "kspell", -- Currently active dictionary
}
vim.opt.completeopt = {
    "menuone",
    "noselect",
    "fuzzy",
}

-- Clipboard
Config.later(function() vim.o.clipboard = "unnamedplus" end) -- Use system clipboard

-- Diagnostics
---@type vim.diagnostic.Opts
local diagnostic_opts = {
    -- Show warning and error signs on top of any other signs
    signs = {
        priority = 9999,
        severity = {
            min = "WARN",
            max = "ERROR",
        },
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN] = "󰀪",
            [vim.diagnostic.severity.INFO] = "󰋽",
            [vim.diagnostic.severity.HINT] = "󰌶",
        },
    },

    -- Show must important diagnostics first
    severity_sort = true,

    -- Underline all diagnostics
    underline = {
        severity = {
            min = "HINT",
            max = "ERROR",
        },
    },

    -- Show more details for errors
    virtual_lines = false,
    virtual_text = {
        current_line = true,
        severity = {
            min = "ERROR",
            max = "ERROR",
        },
    },

    -- Don't update while typing
    update_in_insert = false,
}
-- Load diagnostic config later to avoid performance impact
Config.later(function() vim.diagnostic.config(diagnostic_opts) end)
