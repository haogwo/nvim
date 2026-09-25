-- Reload the current file when another process changes it on disk.
local function check_current_file()
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].buftype ~= "" or vim.bo[buf].modified or vim.api.nvim_buf_get_name(buf) == "" then
    return
  end

  vim.cmd("checktime " .. buf)
end

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  callback = check_current_file,
  desc = "Reload the current file after external changes",
})

-- Focus events do not fire while Neovim stays open in the same terminal.
vim.fn.timer_start(2000, check_current_file, { ["repeat"] = -1 })

local function restore_cursor(buf)
  if vim.api.nvim_get_current_buf() ~= buf or vim.bo[buf].buftype ~= "" then
    return
  end

  local mark = vim.api.nvim_buf_get_mark(buf, '"')
  if mark[1] < 1 or mark[1] > vim.api.nvim_buf_line_count(buf) then
    return
  end

  local line = vim.api.nvim_buf_get_lines(buf, mark[1] - 1, mark[1], false)[1]
  pcall(vim.api.nvim_win_set_cursor, 0, { mark[1], math.min(mark[2], #line) })
end

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Restore the cursor when opening another file",
  callback = function(args)
    if vim.v.vim_did_enter == 1 then
      restore_cursor(args.buf)
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Restore the cursor in the file opened at startup",
  once = true,
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_get_name(buf) == "" then
      return
    end

    -- The startup buffer can be read before its ShaDa quote mark is available.
    pcall(vim.cmd, "rshada!")
    restore_cursor(buf)
  end,
})
