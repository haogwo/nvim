return {
  -- Mason: manage language server
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig",
    },
    opts = {},
  },
  {
    "williamboman/mason-lspconfig",
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "html",
        "cssls",
        "ts_ls",
        "jsonls",
      }
    }
  }
}
