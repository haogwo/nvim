local M = {}

function M.setup()
  local ok, lualine = pcall(require, 'lualine')
  if not ok then
    vim.notify('[lualine] not found', vim.log.levels.WARN)
    return
  end

  lualine.setup({
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 300,
        tabline = 300,
        winbar = 300,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {
        'branch',
        'diff',
        {
          'diagnostics',
          symbols = {
            error = ' ',
            warn  = ' ',
            info  = ' ',
            hint  = '💡 ',
          },
        },
      },
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    -- 自定义 tabline 设置
    tabline = {
      lualine_a = {
        {
          'buffers',
          symbols = {
            modified = ' ●',
            alternate_file = '',
            directory = '',
          },
        }
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {
        {
          'tabs',
          symbols = {
            modified = ' ●',
            alternate_file = '',
          },
        }
      }
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  })
end

return M
