local M = {}

local uv = vim.uv or vim.loop

-- Thresholds
M.size_threshold = 500 * 1024   -- 500KB
M.line_threshold = 20000        -- 20k lines

---Determine if a buffer is considered a big file
---@param buf integer|nil 0 or nil means current buffer
---@return boolean
function M.is_bigfile(buf)
  if buf == nil or buf == 0 then
    buf = vim.api.nvim_get_current_buf()
  end
  local name = vim.api.nvim_buf_get_name(buf)
  -- Check size
  if name ~= "" then
    local ok, stat = pcall(uv.fs_stat, name)
    if ok and stat and stat.size and stat.size > M.size_threshold then
      return true
    end
  end
  -- Check lines
  local lines = vim.api.nvim_buf_line_count(buf)
  if lines > M.line_threshold then
    return true
  end
  return false
end

---Apply local degraded settings for big files
---@param buf integer|nil 0 or nil means current buffer
function M.apply(buf)
  if buf == nil or buf == 0 then
    buf = vim.api.nvim_get_current_buf()
  end
  -- mark buffer
  pcall(vim.api.nvim_buf_set_var, buf, 'bigfile', true)

  -- Lighter local options
  vim.api.nvim_buf_call(buf, function()
    vim.opt_local.spell = false
    vim.opt_local.cursorline = false
    vim.opt_local.cursorcolumn = false
    vim.opt_local.relativenumber = false
    -- Avoid expensive folds
    if vim.opt_local.foldmethod:get() ~= 'manual' then
      vim.opt_local.foldmethod = 'manual'
    end
  end)

  -- If treesitter is active, try disabling heavy modules for this buffer
  pcall(vim.cmd, 'silent! TSBufDisable highlight')
  pcall(vim.cmd, 'silent! TSBufDisable indent')
  pcall(vim.cmd, 'silent! TSBufDisable incremental_selection')

  -- If hlchunk is active, disable its modules just in case
  pcall(vim.cmd, 'silent! DisableHLchunk')
  pcall(vim.cmd, 'silent! DisableHLindent')
end

return M
