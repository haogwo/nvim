local M = {}

function M.setup()
  local ok, telescope = pcall(require, 'telescope')
  if not ok then
    vim.notify('[telescope] not found', vim.log.levels.WARN)
    return
  end

  telescope.setup({
    defaults = {
      prompt_prefix = '  ',
      selection_caret = ' ',
      path_display = { 'smart' },
      mappings = {},
    },
    pickers = {
      find_files = { hidden = true },
    },
    extensions = {
      file_browser = {
        hijack_netrw = true,
        hidden = true,
        grouped = true,
        respect_gitignore = true,
      },
    },
  })

  pcall(telescope.load_extension, 'file_browser')
end

return M
