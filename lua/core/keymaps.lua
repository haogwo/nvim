---- set the leader key as space key ----
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

---- move the selected lines in visual mode ----
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

---- no highlighting ----
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- 将 Visual 模式下的 Y 键映射为复制到系统剪贴板
vim.api.nvim_set_keymap('v', 'Y', '"+y', { noremap = true, silent = false })

---- move cursor in splited windows ----
keymap.set("n", "<leader>k", "<C-w>k")
keymap.set("n", "<leader>j", "<C-w>j")
keymap.set("n", "<leader>h", "<C-w>h")
keymap.set("n", "<leader>l", "<C-w>l")

---- LSP ----
vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap("n", "<C-d>", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

-- ---- telescope ----
-- local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")
-- vim.keymap.set("n", "<tab>", ":Telescope file_browser<CR>")

