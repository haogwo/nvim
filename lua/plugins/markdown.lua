return {
  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("markview").setup({
        modes = { "n", "i", "v" },
        hybrid_modes = { "i" },

        -- 原有预览配置
        tables = { enable = true, use_virtual_lines = true },
        code_blocks = { enable = true, style = "filled" },
        headings = { enable = true },
        checkboxes = { enable = true },

        -- 🔥 新增：目录（TOC）配置
        toc = {
          enable = true,     -- 开启目录
          position = "right", -- 目录位置：left / right
          width = 30,        -- 目录宽度
          hl_group = "Normal", -- 高亮组
          -- 显示各级标题
          show_levels = { 1, 2, 3, 4, 5, 6 },
          -- 缩进
          indent = "  ",
          -- 图标（需 Nerd Font）
          icons = {
            ["1"] = "󰉫 ",
            ["2"] = "󰉬 ",
            ["3"] = "󰉭 ",
            ["4"] = "󰉮 ",
            ["5"] = "󰉯 ",
            ["6"] = "󰉰 ",
          },
        },
      })

      local markview = require("markview")

      -- 1. 单窗口预览
      vim.keymap.set("n", "<leader>mv", "<cmd>Markview toggle<cr>", {
        desc = "📝 Markdown 预览"
      })

      -- 2. 分屏预览（编辑 + 预览）
      vim.keymap.set("n", "<leader>ms", function()
        markview.commands.splitToggle()
      end, { desc = "🖥️ 分屏预览" })

      -- 3. 🔥 目录开关（你要的功能）
      vim.keymap.set("n", "<leader>mt", function()
        markview.commands.tocToggle()
      end, { desc = "📑 目录开关" })
    end
  },
}
