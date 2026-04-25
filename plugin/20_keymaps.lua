-- Basic mappings =============================================================

-- File browsing
vim.keymap.set(
    { "n" },
    "-",
    function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end,
    { desc = "Open file explorer" }
)

-- Flash
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, {
    desc = "Flash",
})
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, {
    desc = "Flash Treesitter",
})
vim.keymap.set({ "o" }, "r", function() require("flash").remote() end, {
    desc = "Remote Flash",
})
vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, {
    desc = "Treesitter Search",
})

-- Search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear hlsearch" })

-- Split navigation
local set_split_keymap = function(key, direction)
    -- Alt + direction to move
    vim.keymap.set(
        { "n", "i", "v" },
        "<A-" .. key .. ">",
        function() Config.now(require("smart-splits")["move_cursor_" .. direction]) end
    )
    -- Alt + Shift + direction to resize
    vim.keymap.set(
        { "n", "i", "v" },
        "<A-" .. key:upper() .. ">",
        function() Config.now(require("smart-splits")["resize_" .. direction]) end
    )
end
set_split_keymap("h", "left")
set_split_keymap("j", "down")
set_split_keymap("k", "up")
set_split_keymap("l", "right")

-- Terminal
vim.keymap.set(
    "t",
    "<C-space>",
    [[<C-\><C-n>]],
    { desc = "Exit insert mode in terminal", silent = true, noremap = true }
)

-- Leader mappings ============================================================
-- Helper to create a keymap prefixed by leader key
local map_leader = function(mode, suffix, rhs, desc) vim.keymap.set(mode, "<leader>" .. suffix, rhs, { desc = desc }) end
-- Helper to create a leader keymap in normal mode
local nmap_leader = function(suffix, rhs, desc) map_leader("n", suffix, rhs, desc) end
-- Helper to create a leader keymap in visual mode
local xmap_leader = function(suffix, rhs, desc) map_leader("x", suffix, rhs, desc) end

-- Prefixes
Config.leader_group_clues = {
    { mode = "n", keys = "<leader>b", desc = "Buffer" },
    { mode = "n", keys = "<leader>c", desc = "Config" },
    { mode = "n", keys = "<leader>f", desc = "Find" },
    { mode = "n", keys = "<leader>g", desc = "Git" },
    { mode = "n", keys = "<leader>gb", desc = "Branch" },
    { mode = "n", keys = "<leader>gf", desc = "Fetch" },
    { mode = "n", keys = "<leader>gF", desc = "Force" },
    { mode = "n", keys = "<leader>l", desc = "LSP/Language" },
    { mode = "n", keys = "<leader>s", desc = "Split" },
    { mode = "n", keys = "<leader>st", desc = "Split Terminal" },
    { mode = "n", keys = "<leader>S", desc = "Session" },
}

-- Buffer
nmap_leader("bd", function() MiniBufremove.delete() end, "Delete")
nmap_leader("bD", function() MiniBufremove.delete(0, true) end, "Delete (force)")
nmap_leader("bs", function() vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true)) end, "Scratch")

-- Config
local edit_config_file = function(filename)
    return string.format("<cmd>edit %s/plugin/%s<cr>", vim.fn.stdpath("config"), filename)
end
nmap_leader("ci", "<cmd>edit $MYVIMRC<cr>", "init.lua")
nmap_leader("ck", edit_config_file("20_keymaps.lua"), "Keymaps")
nmap_leader("cm", edit_config_file("30_mini.lua"), "Mini")
nmap_leader("co", edit_config_file("10_options.lua"), "Options")
nmap_leader("cp", edit_config_file("40_plugins.lua"), "Plugins")

-- Fuzzy find
nmap_leader("fb", "<cmd>Pick buffers<cr>", "Buffers")
nmap_leader("fB", "<cmd>Pick git_branches<cr>", "Branches")
nmap_leader("fc", "<cmd>Pick git_commits<cr>", "Commits")
nmap_leader("fc", '<cmd>Pick git_commits path="%"<cr>', "Commits (current file)")
nmap_leader("fd", '<cmd>Pick diagnostic scope="all"<cr>', "Diagnostics")
nmap_leader("fD", '<cmd>Pick diagnostic scope="current"<cr>', "Diagnostics (current file)")
nmap_leader("ff", "<cmd>Pick files<cr>", "Files")
nmap_leader("fg", "<cmd>Pick grep_live<cr>", "Grep")
nmap_leader("fG", '<cmd>Pick grep pattern="<cword>"<cr>', "Grep current word")
nmap_leader("fh", "<cmd>Pick git_hunks<cr>", "Git hunks")
nmap_leader("fH", "<cmd>Pick help<cr>", "Help")
nmap_leader("fl", '<cmd>Pick list scope="location-list"<cr>', "Location list")
nmap_leader("fp", "<cmd>Pick projects<cr>", "Projects")
nmap_leader("fq", '<cmd>Pick list scope="quickfix"<cr>', "Quickfix")
nmap_leader("fr", "<cmd>Pick resume<cr>", "Resume")
nmap_leader("fs", '<cmd>Pick lsp scope="workspace_symbol_live"<cr>', "Symbols")
nmap_leader("fS", '<cmd>Pick lsp scope="document_symbol"<cr>', "Symbols (current file)")

-- Git
local git_log_format = [[format:\%h\ \%as\ │\ \%s]]
nmap_leader("gbb", function()
    local get_branch_name = function(item) return item:match("^%*?%s*(%S+)") end
    local item = MiniPick.builtin.cli({
        command = {
            "git",
            "branch",
            "-v",
            "--no-color",
            "--list",
            "--sort=-committerdate",
        },
    })
    if item == nil then return end
    local branch = get_branch_name(item)
    vim.cmd("Git checkout " .. branch)
end, "Checkout")
nmap_leader("gbc", function()
    local branch_name = vim.fn.input("New branch name: ")
    if branch_name ~= nil then vim.cmd("Git checkout -b " .. branch_name) end
end, "Create")
nmap_leader("gc", "<cmd>Git commit -v<cr>", "Commit")
nmap_leader("gC", "<cmd>Git commit -v --amend<cr>", "Commit amend")
nmap_leader("gd", "<cmd>Git diff<cr>", "Diff")
nmap_leader("gD", "<cmd>Git diff -- %<cr>", "Diff (current file)")
nmap_leader("gff", "<cmd>Git fetch --all<cr>", "fetch")
nmap_leader("gFP", "<cmd>Git push --force-with-lease<cr>", "Push (force with lease)")
nmap_leader("gl", "<cmd>Git log --pretty=" .. git_log_format .. " --topo-order<cr>", "Log")
nmap_leader("gL", "<cmd>Git log --pretty=" .. git_log_format .. " --topo-order --follow -- %<cr>", "Log (current file)")
nmap_leader("go", function() MiniDiff.toggle_overlay() end, "Toggle overlay")
nmap_leader("gp", "<cmd>Git pull<cr>", "Pull")
nmap_leader("gP", "<cmd>Git push<cr>", "Push")
nmap_leader("gr", "<cmd>Git rebase --interactive --autosquash<cr>", "Rebase (upstream)")
nmap_leader("gR", function()
    local item = MiniPick.builtin.cli({
        command = {
            "bash",
            "-c",
            "git --no-pager log '--format=format:%h %s' && git --no-pager branch -a --format='%(refname:short)'",
        },
    })
    if item == nil then return end
    local target = item:match("^%*?%s*(%S+)")
    vim.cmd("Git rebase --interactive --autosquash " .. target)
end, "Rebase")
nmap_leader("gs", function() MiniGit.show_at_cursor() end, "Show at cursor")
xmap_leader("gs", function() MiniGit.show_at_cursor() end, "Show at selection")

-- LSP/Language
nmap_leader("la", function() vim.lsp.buf.code_action() end, "Actions")
nmap_leader("ld", '<cmd>Pick lsp scope="definition"<cr>', "Definition")
nmap_leader("lD", '<cmd>Pick lsp scope="declaration"<cr>', "Declaration")
nmap_leader("lf", function() require("conform").format({ async = true }) end, "Format")
xmap_leader("lf", function() require("conform").format({ async = true }) end, "Format range")
nmap_leader("li", '<cmd>Pick lsp scope="implementation"<cr>', "Implementation")
nmap_leader("lr", '<cmd>Pick lsp scope="references"<cr>', "References")
nmap_leader("lR", function() vim.lsp.buf.rename() end, "Rename")
nmap_leader("lt", '<cmd>Pick lsp scope="type_definition"<cr>', "Type definition")

-- Session
nmap_leader("Sd", function() MiniSessions.select("delete") end, "Delete session")
nmap_leader("Sl", function() MiniSessions.select("read") end, "Load session")
nmap_leader("Sn", function() MiniSessions.write(vim.fn.input("Session name: ")) end, "New session")
nmap_leader("Sr", function() MiniSessions.restart() end, "Restart session")
nmap_leader("Ss", function() MiniSessions.select("write") end, "Save session")

-- Splits
nmap_leader("sh", "<cmd>split<cr>", "Create horizontal split")
nmap_leader("sr", "<cmd>vertical wincmd = | horizontal wincmd =<cr>", "Resize splits")
nmap_leader("sv", "<cmd>vsplit<cr>", "Create vertical split")
nmap_leader("sx", "<cmd>close<cr>", "Close the current split")

-- Terminal splits
nmap_leader("sth", "<cmd>split<cr><cmd>terminal<cr>i", "Create horizontal terminal")
nmap_leader("stt", "<cmd>terminal<cr>i", "Create terminal in current split")
nmap_leader("stv", "<cmd>vsplit<cr><cmd>terminal<cr>i", "Create vertical terminal")
