return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter").setup()

      -- 安装所需 parser（异步，不阻塞启动）
      require("nvim-treesitter.install").install({
        "vim", "vimdoc", "bash", "c", "cpp", "java", "lua",
        "html", "css", "go", "python", "javascript", "typescript", "json", "sql",
        "markdown", "markdown_inline", "graphql", "vue",
      }, { skip_installed = true })

      -- 启用 highlight（跳过大文件）
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local max_filesize = 512 * 1024
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
          if ok and stats and stats.size > max_filesize then
            return
          end
          pcall(vim.treesitter.start)
        end,
      })

      -- 启用 treesitter indent
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
