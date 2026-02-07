-- This file defines keymaps for various plugins.
-- Each plugin has its own table of keymaps, which can be used in lazy.nvim specs or applied globally.

local M = {}

-- Helper to define keymaps declaratively for plugins
-- Returns a list suitable for lazy.nvim 'keys' spec or can be consumed manually

M.autopairs = {
  -- Fast wrap trigger (Insert mode)
  {
    mode = 'i',
    lhs = '<M-e>',
    rhs = function()
      local ok, ap = pcall(require, 'nvim-autopairs.fastwrap')
      if ok then ap:show() end
    end,
    opts = { desc = 'autopairs: fast wrap' },
  },
}

M.neogit = {
  {
    lhs = '<leader>gg',
    rhs = '<cmd>Neogit<CR>',
    opts = { desc = 'neogit: open status' },
  },
}

M.diffview = {
  {
    lhs = '<leader>gd',
    rhs = '<cmd>DiffviewOpen<CR>',
    opts = { desc = 'diffview: open' },
  },
  {
    lhs = '<leader>gD',
    rhs = '<cmd>DiffviewFileHistory %<CR>',
    opts = { desc = 'diffview: file history' },
  },
  {
    lhs = '<leader>gc',
    rhs = '<cmd>DiffviewClose<CR>',
    opts = { desc = 'diffview: close' },
  },
}

M.telescope = (function()
  local function tb(fn)
    return function()
      local ok, builtin = pcall(require, 'telescope.builtin')
      if ok then return builtin[fn]() end
    end
  end
  return {
    { lhs = '<leader>ff', rhs = tb('find_files'), opts = { desc = 'telescope: find files' } },
    { lhs = '<leader>fg', rhs = tb('live_grep'),  opts = { desc = 'telescope: live grep' } },
    { lhs = '<leader>fb', rhs = tb('buffers'),    opts = { desc = 'telescope: buffers' } },
    { lhs = '<leader>fh', rhs = tb('help_tags'),  opts = { desc = 'telescope: help tags' } },
    { lhs = '<Tab>',      rhs = function() require('telescope').extensions.file_browser.file_browser() end, opts = { desc = 'telescope: file browser' } },
  }
end)()

-- LSP keymaps (buffer-local via plugins/config/lsp/lspconfig.lua on_attach)
M.lsp = {
  -- Common navigations
  { lhs = '<leader>gd', rhs = function() vim.lsp.buf.definition() end, opts = { desc = 'lsp: goto definition' } },
  { lhs = '<leader>gr', rhs = function() vim.lsp.buf.references() end, opts = { desc = 'lsp: references' } },
  { lhs = '<leader>gi', rhs = function() vim.lsp.buf.implementation() end, opts = { desc = 'lsp: implementation' } },
  { lhs = '<C-d>', rhs = function() vim.lsp.buf.hover() end, opts = { desc = 'lsp: hover' } },
}

return M
