local opt = vim.opt
local config_path = os.getenv("PWD")

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

---- behavior ----
opt.splitright = true
opt.splitbelow = true

---- search ----
opt.ignorecase = true
opt.smartcase = true

---- set cursor position to last opened ----
vim.cmd([[
    augroup resCur
      autocmd!
      autocmd BufReadPost * call setpos(".", getpos("'\""))
    augroup END
]])

---- undo! backup! and swp!!! ----
vim.cmd([[
    silent !mkdir -p $HOME/.config/nvim/tmp/backup
    silent !mkdir -p $HOME/.config/nvim/tmp/undo
    set backupdir=$HOME/.config/nvim/tmp/backup,.
    set directory=$HOME/.config/nvim/tmp/backup,.
    if has('persistent_undo')
        set undofile
        set undodir=$HOME/.config/nvim/tmp/undo,.
    endif
]])


vim.cmd [[
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab
    autocmd FileType json setlocal shiftwidth=2 tabstop=2 expandtab
    autocmd FileType lua setlocal shiftwidth=2 tabstop=2 expandtab
]]

--- Enable clipboard with OSC 52 ---
if vim.fn.has('nvim-0.10') == 1 then
    vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
            ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
            ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
            ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
            ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
        },
    }
end

