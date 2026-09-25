-- Core editor options.
local opt = vim.opt
local fn = vim.fn

-- Use tmux inside or outside SSH; direct SSH uses OSC 52. Local Nvim auto-detects.
if vim.env.TMUX then
    vim.g.clipboard = "tmux"
elseif vim.env.SSH_CONNECTION then
    vim.g.clipboard = "osc52"
end

opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
-- Indent inside Python brackets once; align the closing bracket with its line.
vim.g.python_indent = {
    open_paren = "shiftwidth()",
    closed_paren_align_last_line = false,
}
opt.cursorline = true
opt.cursorcolumn = true
opt.termguicolors = true
opt.background = "dark"
vim.cmd("syntax enable")
opt.signcolumn = "yes"
opt.shell = "zsh"
opt.wrap = false
opt.mouse = ""  -- disable mouse
opt.autoread = true
opt.backupcopy = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.timeoutlen = 300
opt.updatetime = 200

---- behavior ----
opt.splitright = true
opt.splitbelow = true

---- search ----
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- 使用 stdpath 配置 swap/backup/undo 目录
local state_dir = fn.stdpath("state")
local swap_dir = state_dir .. "/swap"
local backup_dir = state_dir .. "/backup"
local undo_dir = state_dir .. "/undo"

for _, dir in ipairs({ swap_dir, backup_dir, undo_dir }) do
    if fn.isdirectory(dir) == 0 then
        fn.mkdir(dir, "p")
    end
end

opt.backup = true
opt.writebackup = true
opt.backupdir = backup_dir .. "//"
opt.directory = swap_dir .. "//"
opt.undofile = true
opt.undodir = undo_dir
