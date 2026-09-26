-- Install and load external plugins before their configuration modules.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(args)
    local data = args.data
    if data.spec.name ~= "telescope-fzf-native.nvim" or (data.kind ~= "install" and data.kind ~= "update") then
      return
    end

    local result = vim.system({ "make" }, { cwd = data.path, text = true }):wait()
    if result.code ~= 0 then
      error("Failed to build telescope-fzf-native.nvim: " .. (result.stderr or "unknown error"))
    end
  end,
})

vim.pack.add({
  { src = "https://github.com/haogwo/xuantong", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lualine/lualine.nvim", version = "master" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-file-browser.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/shellRaining/hlchunk.nvim" },
  { src = "https://github.com/folke/todo-comments.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/Saghen/blink.cmp", version = "v1" },
  { src = "https://github.com/b0o/SchemaStore.nvim" },
})
