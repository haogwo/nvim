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

--- Enable clipboard with OSC 52 ---
-- 优先直写主 client 的 tty（绕过 tmux 拦截），不可用时回退到内置实现
local osc52_mod = require('vim.ui.clipboard.osc52')

local function osc52_direct_copy(text)
    local tty_file = '/tmp/tmux-main-tty-' .. (vim.env.USER or '')
    local f = io.open(tty_file, 'r')
    if not f then
        return false
    end
    local tty = f:read('*l')
    f:close()
    if not tty then
        return false
    end
    local out = io.open(tty, 'w')
    if not out then
        return false
    end
    out:write('\x1b]52;c;' .. vim.base64.encode(text) .. '\x07')
    out:flush()
    out:close()
    return true
end

local function make_copy_handler(reg)
    return function(lines, _)
        local text = table.concat(lines, '\n')
        if not osc52_direct_copy(text) then
            osc52_mod.copy(reg)(lines, _)
        end
    end
end

vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
        ['+'] = make_copy_handler('+'),
        ['*'] = make_copy_handler('*'),
    },
    paste = {
        ['+'] = osc52_mod.paste('+'),
        ['*'] = osc52_mod.paste('*'),
    },
}

