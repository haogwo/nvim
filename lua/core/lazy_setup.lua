-- Auto download and load Lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup({
  spec = {
    { import = "plugins.appearance" },
    { import = "plugins.tools" },
    { import = "plugins.lsp" },
  },
  -- 其他配置 (如 UI 或并发设置)
  install = { 
      colorscheme = { "everforest" } 
  },
})

