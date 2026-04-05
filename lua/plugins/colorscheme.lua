return {
  -- {
  --   "haogwo/gruvbox.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("gruvbox").setup({
  --       variant = "dark-hard",
  --       italics = true,
  --       transparent = false,
  --     })
  --     vim.cmd.colorscheme("gruvbox-dark-hard")
  --   end,
  -- },
  {
    "neanias/everforest-nvim",
    lazy = false,                         -- load at startup to avoid colorscheme flash
    priority = 1000,                      -- load before other UI plugins
    version = false,                      -- use latest
    opts = {
      background = "hard",                -- hardness: soft | medium | hard
      transparent_background_level = 0,   -- 0..2
      italics = true,
      disable_italic_comments = false,
      sign_column_background = "grey",        -- none | grey
      ui_contrast = "low",                    -- low | high
      show_eob = false,                       -- hide end-of-buffer tildes
      diagnostic_virtual_text = "coloured",   -- coloured | grey
      diagnostic_text_highlight = false,
      diagnostic_line_highlight = false,
    },
    config = function(_, opts)
      -- Apply your preferred theme options
      require("everforest").setup(opts)
      vim.cmd.colorscheme("everforest")
    end,
  }
}
