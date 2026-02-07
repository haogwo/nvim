return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cond = function()
      -- Skip loading on very large files to avoid overhead (reuse core.bigfile)
      local ok, bigfile = pcall(require, 'core.bigfile')
      if ok and bigfile then
        return not bigfile.is_bigfile(0)
      end
      return true
    end,
    config = function()
      require("plugins.config.hlchunk").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "vim", "vimdoc", "bash", "c", "cpp", "java", "lua",
        "html", "css", "go", "python", "javascript", "json", "sql",
        "markdown", "markdown_inline",
      },
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 512 * 1024 -- 512 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = { enable = true },
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
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      require("plugins.config.telescope").setup()
      -- Bind centralized keymaps
      local maps = require('keymaps').for_plugin('telescope')
      for _, m in ipairs(maps) do
        vim.keymap.set(m.mode or 'n', m.lhs, m.rhs, m.opts or { silent = true })
      end
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      fast_wrap = {
        map = false, -- 按键统一在 keymaps 中集中管理
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      -- 绑定集中声明的插件键位
      local maps = require('keymaps').for_plugin('autopairs')
      for _, m in ipairs(maps) do
        vim.keymap.set(m.mode or 'n', m.lhs, m.rhs, m.opts or { silent = true })
      end
    end,
  },

}
