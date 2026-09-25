local palette = require("xuantong.palette")
local treesitter = require("plugins.treesitter")

local colors = {
    RainbowDelimiterRed = palette.ansi[2],
    RainbowDelimiterYellow = palette.ansi[4],
    RainbowDelimiterBlue = palette.ansi[5],
    RainbowDelimiterOrange = palette.ansi[6],
    RainbowDelimiterGreen = palette.ansi[3],
    RainbowDelimiterViolet = palette.ansi[13],
    RainbowDelimiterCyan = palette.ansi[7],
}

local function apply_colors()
    for group, fg in pairs(colors) do
        vim.api.nvim_set_hl(0, group, { fg = fg })
    end
end

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("xuantong_rainbow", { clear = true }),
    pattern = "xuantong",
    callback = apply_colors,
})
apply_colors()

vim.g.rainbow_delimiters = {
    condition = treesitter.allow_treesitter,
    highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
    },
}
