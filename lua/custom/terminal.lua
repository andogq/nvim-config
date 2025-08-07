-- Keymaps
vim.keymap.set('n', '<leader>tt', '<cmd>terminal<cr>i', { desc = 'Launch terminal in insert mode' })
vim.keymap.set('t', '<C-space>', [[<C-\><C-n>]], { desc = 'Exit insert mode in terminal', silent = true, noremap = true })
vim.keymap.set('t', '<S-Enter>', '<Enter>', { desc = 'Insert enter' })
vim.keymap.set('t', '<S-Space>', '<Space>', { desc = 'Insert space' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

return {}
