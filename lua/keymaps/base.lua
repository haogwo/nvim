-- This file defines core keymaps that do not depend on any plugins.
-- These keymaps enhance basic navigation, editing, and clipboard operations.

local M = {}

local map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.setup()
  -- Better window navigation
  map('n', '<C-h>', '<C-w>h')
  map('n', '<C-j>', '<C-w>j')
  map('n', '<C-k>', '<C-w>k')
  map('n', '<C-l>', '<C-w>l')

  -- Clear search highlight
  map('n', '<leader>nh', '<cmd>nohlsearch<CR>')

  -- System clipboard yank/paste shortcuts
  map('v', 'Y', '"+Y')

  -- Move lines (visual mode)
  map('v', 'J', ":m '>+1<CR>gv=gv")
  map('v', 'K', ":m '<-2<CR>gv=gv")

  -- Keep search centered
  map('n', 'n', 'nzz')
  map('n', 'N', 'Nzz')
end

return M
