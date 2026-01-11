return {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  -- Sets main modules to use for opts
  main = "nvim-treesitter.configs",
  -- [[ Configure Treesitter ]] See: `:help nvim-treesitter`
  opt = {
    ensure_installed = { 
        "vim", "vimdoc", "bash", "c", "cpp", "java", "lua", 
        "html", "css", "go", "python", "javascript", "json", "sql", 
        "markdown", "markdown_inline" 
    },
    auto_install = true,
    highlight = {
      enable = true,
      -- disable highlight when file is too large(max size: 512KB)
      disable = function(lang, buf)
        local max_filesize = 512 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    indent = { enable = true },
  }
}
