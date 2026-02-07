return {

  -- Colorscheme List
  {
    "neanias/everforest-nvim",
    lazy = false,     -- load at startup to avoid colorscheme flash
    priority = 1000, -- load before other UI plugins
    version = false, -- use latest
    config = function()
      -- Apply your preferred theme options
      require("everforest").setup({
        background = "hard",              -- hardness: soft | medium | hard
        transparent_background_level = 0, -- 0..2
        italics = true,
        disable_italic_comments = false,
        sign_column_background = "grey",      -- none | grey
        ui_contrast = "low",                 -- low | high
        show_eob = false,                     -- hide end-of-buffer tildes
        diagnostic_virtual_text = "coloured", -- coloured | grey
        diagnostic_text_highlight = false,
        diagnostic_line_highlight = false,
      })
      vim.cmd.colorscheme("everforest")
    end,
  },
  {
    "navarasu/onedark.nvim",
    version = "v0.1.0", -- Pin to legacy version
    lazy = true,
    priority = 1000,
    config = function()
      require('onedark').setup({
        style = 'cool'
      })
      -- require('onedark').load()
      -- vim.cmd.colorscheme("onedark")
    end
  },
  {
    "Mofiqul/vscode.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("vscode").setup({
        style = 'dark',
        -- Enable italic comment
        italic_comments = true,
        -- Underline `@markup.link.*` variants
        underline_links = true,
        -- Disable nvim-tree background color
        disable_nvimtree_bg = true,
        -- Apply theme colors to terminal
        terminal_colors = true,
      })
      -- vim.cmd.colorscheme("vscode")
    end
  },


  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { { "nvim-tree/nvim-web-devicons", lazy = true, optional = true } },
    config = function()
      require("plugins.config.lualine").setup()
    end,
  },
}
