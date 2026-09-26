local palette = require("xuantong.palette")
local filetype_icon_fg = palette.ansi[7]

local function filetype_icon()
    local devicons = require("nvim-web-devicons")
    local icon = devicons.get_icon(vim.fn.expand("%:t"))
        or devicons.get_icon_by_filetype(vim.bo.filetype)
    return icon or ""
end

local function mode_colors(accent)
    return {
        a = { fg = palette.background, bg = accent, gui = "bold" },
        b = { fg = palette.foreground, bg = palette.cursor_background },
        c = { fg = palette.foreground, bg = palette.background },
    }
end

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = {
            normal = mode_colors(palette.ansi[5]),
            insert = mode_colors(palette.ansi[3]),
            visual = mode_colors(palette.ansi[6]),
            replace = mode_colors(palette.ansi[2]),
            command = mode_colors(palette.ansi[4]),
            inactive = {
                a = { fg = palette.ansi[9], bg = palette.cursor_background },
                b = { fg = palette.ansi[9], bg = palette.cursor_background },
                c = { fg = palette.ansi[9], bg = palette.background },
            },
        },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = false,
        refresh = {
            statusline = 300,
            tabline = 300,
            winbar = 300,
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            "branch",
            {
                "diff",
                diff_color = {
                    added = { fg = palette.ansi[3] },
                    modified = { fg = palette.ansi[4] },
                    removed = { fg = palette.ansi[2] },
                },
            },
            {
                "diagnostics",
                symbols = {
                    error = " ",
                    warn = " ",
                    info = " ",
                    hint = "󰌵 ",
                },
            },
        },
        lualine_c = { "filename" },
        lualine_x = {
            "encoding",
            "fileformat",
            {
                filetype_icon,
                color = { fg = filetype_icon_fg },
                padding = { left = 1, right = 0 },
                separator = "",
            },
            { "filetype", icons_enabled = false, padding = { left = 1, right = 1 } },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {
        lualine_a = {
            {
                "buffers",
                symbols = {
                    modified = " ●",
                    alternate_file = "",
                    directory = "",
                },
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
            {
                "tabs",
                symbols = {
                    modified = " ●",
                    alternate_file = "",
                },
            },
        },
    },
})
