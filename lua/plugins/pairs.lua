local pairs = require("nvim-autopairs")

pairs.setup({
  check_ts = true,
  map_cr = true,
})

-- Keep the closing quotes at the statement indent. When the opening quotes
-- follow code, indent the content one level; standalone docstrings keep their indent.
for _, quote in ipairs({ '"""', "'''" }) do
  pairs.get_rules(quote)[1]:replace_map_cr(function(opts)
    local indent = opts.line:match("^[ \t]*") or ""
    local before = opts.line:sub(1, opts.color or #opts.line)
    local content_indent = before:sub(#indent + 1) == quote and "" or "<C-t>"
    return "<C-g>u<CR><CR>0<C-d>" .. indent .. "<Up>" .. indent .. content_indent
  end)
end

local function in_python_multiline_string(bufnr)
  if vim.bo[bufnr].filetype ~= "python" then
    return false
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  if vim.treesitter.highlighter.active[bufnr] then
    local ok, node = pcall(function()
      local parser = vim.treesitter.get_parser(bufnr)
      parser:parse()
      return vim.treesitter.get_node({ bufnr = bufnr, pos = { row - 1, math.max(col - 1, 0) } })
    end)
    if ok then
      while node do
        if node:type() == "string" then
          local start_row, _, end_row = node:range()
          return end_row > start_row
        end
        node = node:parent()
      end
    end
  end

  -- Large files keep Vim's syntax highlighter instead of Tree-sitter.
  if vim.bo[bufnr].syntax ~= "" then
    local group = vim.fn.synIDattr(vim.fn.synID(row, math.max(col, 1), true), "name")
    return group:match("String$") ~= nil
  end
  return false
end

-- Blink accepts a visible completion item first and falls back to this map.
-- Python's indent expression can align a new string line to an outer '('.
vim.keymap.set("i", "<CR>", function()
  local result = pairs.completion_confirm()
  if result ~= pairs.esc("<cr>") then
    return result
  end

  local bufnr = vim.api.nvim_get_current_buf()
  if in_python_multiline_string(bufnr) then
    local indent = vim.api.nvim_get_current_line():match("^[ \t]*") or ""
    return result .. pairs.esc("0<C-d>" .. indent)
  end
  return result
end, { expr = true, replace_keycodes = false, desc = "Insert newline with paired quotes" })
