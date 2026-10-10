local api = vim.api
local palette = require("xuantong.palette")
local git_colors = {
    foreground = palette.foreground,
    background = palette.background,
    border = "#8b949e",
    add = "#3fb950",
    change = "#d29922",
    delete = "#ff7b72",
}

local function apply_git_colors()
    local signs = {
        GitSignsAdd = git_colors.add,
        GitSignsChange = git_colors.change,
        GitSignsDelete = git_colors.delete,
        GitSignsTopdelete = git_colors.delete,
        GitSignsChangedelete = git_colors.change,
        GitSignsUntracked = git_colors.add,
    }
    for group, fg in pairs(signs) do
        api.nvim_set_hl(0, group, { fg = fg, bold = true })
    end

    api.nvim_set_hl(0, "GitSignsPopupNormal", { fg = git_colors.foreground, bg = git_colors.background })
    api.nvim_set_hl(0, "GitSignsPopupBorder", { fg = git_colors.border, bg = git_colors.background })
    api.nvim_set_hl(0, "GitSignsAddPreview", { fg = git_colors.add, bg = git_colors.background })
    api.nvim_set_hl(0, "GitSignsDeletePreview", { fg = git_colors.delete, bg = git_colors.background })
end

api.nvim_create_autocmd("ColorScheme", {
    group = api.nvim_create_augroup("user_gitsigns_colors", { clear = true }),
    callback = apply_git_colors,
})
apply_git_colors()

api.nvim_create_autocmd("WinNew", {
    group = api.nvim_create_augroup("user_gitsigns_popup", { clear = true }),
    callback = function()
        vim.schedule(function()
            for _, winid in ipairs(api.nvim_list_wins()) do
                if vim.w[winid].gitsigns_preview then
                    vim.wo[winid].winhighlight = "NormalFloat:GitSignsPopupNormal,FloatBorder:GitSignsPopupBorder"
                end
            end
        end)
    end,
})

local gitsigns = require("gitsigns")
gitsigns.setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "-" },
        changedelete = { text = "!" },
        untracked = { text = "?" },
    },
    signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "-" },
        changedelete = { text = "!" },
    },
    signs_staged_enable = true,
    signcolumn = true,
    numhl = false,
    linehl = false,
    current_line_blame = false,
    word_diff = false,
    attach_to_untracked = false,
    max_file_length = 40000,
    preview_config = {
        border = "rounded",
        width = math.min(100, vim.o.columns - 6),
    },
})

local commands = {
    GitNextHunk = { function() gitsigns.nav_hunk("next", { target = "all" }) end, "Go to the next Git change" },
    GitPrevHunk = { function() gitsigns.nav_hunk("prev", { target = "all" }) end, "Go to the previous Git change" },
    GitPreviewHunk = { function() gitsigns.preview_hunk() end, "Preview the current Git change" },
    GitToggleStageHunk = { function() gitsigns.stage_hunk() end, "Stage or unstage the current Git change" },
    GitBlameLine = { function() gitsigns.blame_line({ full = true }) end, "Show Git blame for the current line" },
    GitDiffFile = { function() gitsigns.diffthis() end, "Compare the current file with the Git index" },
}

for name, command in pairs(commands) do
    vim.api.nvim_create_user_command(name, command[1], { desc = command[2] })
end
