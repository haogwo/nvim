return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
    config = function()
      require("plugins.config.lsp.mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      -- mason-lspconfig will be further configured in lspconfig.lua
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", tag = "legacy", event = "LspAttach", opts = {} },
    },
    config = function()
      require("plugins.config.lsp.lspconfig").setup()
    end,
  },
  {
    "stevearc/conform.nvim",
    cmd = { "Format" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("plugins.config.lsp.formatting").setup()
    end,
  },
  -- Completion stack: nvim-cmp + sources + snippets
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      { "rafamadriz/friendly-snippets", lazy = true },
    },
    config = function()
      require("plugins.config.lsp.cmp").setup()
    end,
  },
  -- Optional: icons in completion menus if you later add cmp
  { "onsails/lspkind.nvim", lazy = true },
}
