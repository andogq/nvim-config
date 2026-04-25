vim.treesitter.start()

local bufnr = vim.api.nvim_get_current_buf()

local nmap = function(suffix, rhs, desc) vim.keymap.set("n", suffix, rhs, { desc = desc, silent = true, buf = bufnr }) end
local nmap_leader = function(suffix, rhs, desc) nmap("<leader>" .. suffix, rhs, desc) end

nmap_leader("la", function() vim.cmd.RustLsp("codeAction") end, "Actions")
nmap("K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Hover")
