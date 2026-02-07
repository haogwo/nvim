return {
  {
    "TimUntersberger/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim", -- Recommended for diffing
    },
    cmd = "Neogit",
    config = function()
      require("plugins.config.neogit").setup()
      -- Bind centralized keymaps
      local maps = require('keymaps').for_plugin('neogit')
      for _, m in ipairs(maps) do
        vim.keymap.set(m.mode or 'n', m.lhs, m.rhs, m.opts or { silent = true })
      end
      local diffview_maps = require('keymaps').for_plugin('diffview')
      for _, m in ipairs(diffview_maps) do
        vim.keymap.set(m.mode or 'n', m.lhs, m.rhs, m.opts or { silent = true })
      end
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("plugins.config.gitsigns").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    config = function()
      -- Keymaps are bound in neogit's on_attach, but you could add them here
      -- if you wanted them to be global.
    end,
  },
}
