local M = {}

function M.setup()
  local ok, gitsigns = pcall(require, 'gitsigns')
  if not ok then
    vim.notify('[gitsigns] not found', vim.log.levels.WARN)
    return
  end

  gitsigns.setup({
    signs = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '┃' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signs_staged = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signs_staged_enable = true,
    signcolumn = true,
    numhl      = false,
    linehl     = false,
    word_diff  = false,
    watch_gitdir = { follow_files = true },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      -- 统一管理快捷键配置
      local maps = require('keymaps').for_plugin('gitsigns')
      for _, m in ipairs(maps) do
        local opts = vim.tbl_extend('force', { silent = true, buffer = bufnr }, m.opts or {})
        vim.keymap.set(m.mode or 'n', m.lhs, m.rhs, opts)
      end
    end,
  })

  -- Custom sign colors
  vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#42B883', bold = true })
  vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#42A5F5', bold = true })
  vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#A04040', bold = true })
end

return M
