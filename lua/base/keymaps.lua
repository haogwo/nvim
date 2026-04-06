
-- Better window navigation
vim.keymap.set('n', '<leader>h', '<C-w>h', { desc = 'Go to left window' })
vim.keymap.set('n', '<leader>j', '<C-w>j', { desc = 'Go to lower window' })
vim.keymap.set('n', '<leader>k', '<C-w>k', { desc = 'Go to upper window' })
vim.keymap.set('n', '<leader>l', '<C-w>l', { desc = 'Go to right window' })

-- Resize window splits
vim.keymap.set('n', '<leader>wk', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<leader>wj', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<leader>wh', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<leader>wl', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = 'Equalize window sizes' })

-- Clear search highlight
vim.keymap.set('n', '<leader>nh', '<cmd>nohlsearch<CR>')

-- System clipboard yank/paste shortcuts
vim.keymap.set('v', 'Y', '"+y')

-- Move lines (visual mode)
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Keep search centered
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
