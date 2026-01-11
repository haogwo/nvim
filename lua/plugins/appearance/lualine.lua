return {
    'nvim-lualine/lualine.nvim',
    dependicies = {
        'nvim-tree/nvim-web-devicons',
        opt = true,
    },
    config = function()
        require('lualine').setup {
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
                "diagnostics",
                symbols = {
                  error = ' ',
                  warn  = ' ',
                  info  = ' ',
                  hint  = '󰌵 ',
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
                  modified = ' ●', -- 修改过的缓冲区符号
                  alternate_file = '', -- 当前激活的符号，可以留空避免出现 #
                  directory = '', -- 目录符号（如果需要）
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
                  modified = ' ●', -- 修改过的标签页符号
                  alternate_file = '', -- 当前激活的符号，可以留空避免出现 #
                },
              }
            }
          },
          winbar = {},
          inactive_winbar = {},
          extensions = {}
        }
    end,
}
