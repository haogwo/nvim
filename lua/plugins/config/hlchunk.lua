local M = {}

function M.setup()
  local ok, hlchunk = pcall(require, 'hlchunk')
  if not ok then
    vim.notify('[hlchunk] not found', vim.log.levels.WARN)
    return
  end

  hlchunk.setup({
    chunk = {
      enable = true,
      use_treesitter = true,
      style = {
        { fg = "#42A5F5" },
      },
      chars = {
        horizontal_line = "─",
        vertical_line = "│",
        left_top = "╭",
        left_bottom = "╰",
        right_arrow = ">",
      },
    },
    indent = {
      enable = false,
      chars = { "│", "¦", "┆", "┊" },
      use_treesitter = false,
    },
    blank = {
      enable = true,
      style = {
        "#666666",
        "#555555",
        "#444444",
      },
    },
    line_num = {
      enable = true,
      use_treesitter = true,
      style = { { fg = "#01D758" } },
    },
  })
end

return M
