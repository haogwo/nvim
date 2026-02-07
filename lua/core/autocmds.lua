local api = vim.api
local fn = vim.fn

-- group helpers
local function augroup(name)
  return api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- 1) 打开文件时恢复到上次光标位置
api.nvim_create_autocmd("BufReadPost", {
  group = augroup("restore_cursor"),
  callback = function(args)
    local mark = api.nvim_buf_get_mark(args.buf, '"')
    local lcount = api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(api.nvim_win_set_cursor, 0, { mark[1], mark[2] })
    end
  end,
})

-- 2) 外部文件变更自动检测（配合 opt.autoread）
api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = augroup("checktime"),
  callback = function()
    if fn.mode() ~= "c" then
      pcall(vim.cmd.checktime)
    end
  end,
})

-- 3) 按文件类型设置缩进（如需可改为 ftplugin/*）
api.nvim_create_autocmd("FileType", {
  group = augroup("ft_indent"),
  pattern = { "javascript", "json", "lua" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- 4) 大文件降级：在 BufReadPre/BufNewFile 时检测并应用轻量设置
api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = augroup("bigfile"),
  callback = function(args)
    local bigfile = require('core.bigfile')
    if bigfile.is_bigfile(args.buf) then
      bigfile.apply(args.buf)
    end
  end,
})
