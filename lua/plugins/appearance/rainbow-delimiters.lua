return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    -- 只有在打开文件时才加载，节省启动时间
    event = "BufReadPost",
    config = function()
      -- 导入配置
      local rainbow_delimiters = require 'rainbow-delimiters'

      vim.g.rainbow_delimiters = {
        strategy = {
          -- 默认策略：对所有文件开启彩虹括号
          [''] = rainbow_delimiters.strategy['global'],
          -- 对于非常大的文件，可以切换到更快的 'noop' 策略（不处理）
          commonlisp = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
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
}
