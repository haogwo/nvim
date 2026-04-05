return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        tailwind = true,
        mode = "background",
      },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cond = function()
      local ok, bigfile = pcall(require, 'core.bigfile')
      if ok and bigfile then
        return not bigfile.is_bigfile(0)
      end
      return true
    end,
    config = function()
      local rd = require('rainbow-delimiters')
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rd.strategy["global"],
          commonlisp = rd.strategy["local"],
        },
        query = {
          [""] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
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
        use_treesitter = true,
      },
      blank = {
        enable = false,
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
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { { "nvim-tree/nvim-web-devicons", lazy = true, optional = true } },
    opts = {
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
    }
  },
}
