local M = {}

function M.setup()
  local ok, conform = pcall(require, 'conform')
  if not ok then return end

  conform.setup({
    -- 不在保存时自动格式化，改为手动触发
    format_on_save = false,
    notify_on_error = true,
    formatters_by_ft = {
      lua = { 'stylua' },
      json = { 'jq' },
      yaml = { 'yamlfmt' },
      html = { 'prettierd', 'prettier' },
      css = { 'prettierd', 'prettier' },
      javascript = { 'prettierd', 'prettier' },
      typescript = { 'prettierd', 'prettier' },
      markdown = { 'prettierd', 'prettier' },
      go = { 'gofumpt', 'goimports' },
      python = { 'ruff_format', 'black' },
      sh = { 'shfmt' },
    },
  })

  -- 自定义 :Format 命令（手动格式化当前缓冲）
  vim.api.nvim_create_user_command('Format', function()
    require('conform').format({ async = true, lsp_fallback = true })
  end, { desc = 'Format current buffer' })
end

return M
