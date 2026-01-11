return {
    "shellRaining/hlchunk.nvim",
    ft = { 
        "lua", "python", "go", "javascript", 
        "html", "css", "c", "cpp", "bash",
        "vim", "vimdoc", "markedown"
    },
    config = function() 
        require("hlchunk").setup(
          {
            chunk = {
              enable = true,
              use_treesitter = true,
              style = {
                {fg = "#42A5F5"}
              },
              chars = {
                horizontal_line = "─",
                vertical_line = "│",
                left_top = "╭",
                left_bottom = "╰",
                right_arrow = ">"
              }
            },
            indent = {
              enable = false,
              chars = {"│", "¦", "┆", "┊"},
              use_treesitter = false
            },
            blank = {
              enable = true,
              style = {
                "#666666",
                "#555555",
                "#444444"
              }
            },
            line_num = {
              enable = true,
              use_treesitter = true,
              style = {{fg = "#01D758"}}
            }
          }
        )
    end,
}
