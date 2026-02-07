local opt = vim.opt
local fn = vim.fn

---- appearance ----
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.cursorline = true
opt.cursorcolumn = true
opt.termguicolors = true
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
opt.backupdir = backup_dir
opt.directory = swap_dir
opt.undofile = true
opt.undodir = undo_dir

-- --- Enable clipboard with OSC 52 ---
-- if vim.fn.has('nvim-0.10') == 1 then
--     vim.g.clipboard = {
--         name = 'OSC 52',
--         copy = {
--             ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--             ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--         },
--         paste = {
--             ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--             ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--         },
--     }
-- end

