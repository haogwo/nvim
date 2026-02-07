-- This file initializes and applies keymaps for both core functionality and plugins.
-- Core keymaps are defined in `keymaps.base`.
-- Plugin-specific keymaps are defined in `keymaps.plugins` and applied globally.

local M = {}

-- Apply core/base keymaps (no plugin dependency)
local function apply_base()
  local ok, base = pcall(require, 'keymaps.base')
  if ok and base and type(base.setup) == 'function' then
    base.setup()
  end
end

-- Provide a unified interface for plugin keymaps
-- Usage in plugin specs (lazy.nvim): keys = require('keymaps').for_plugin('telescope')
function M.for_plugin(name)
  local ok, registry = pcall(require, 'keymaps.plugins')
  if ok and registry and type(registry[name]) == 'table' then
    return registry[name]
  end
  return {}
end

-- Apply all plugin keymaps globally (commands will lazy-load plugins as needed)
local function apply_plugin_keymaps()
  local ok, registry = pcall(require, 'keymaps.plugins')
  if not ok or type(registry) ~= 'table' then return end
  for _, maps in pairs(registry) do
    if type(maps) == 'table' then
      for _, m in ipairs(maps) do
        if m and m.lhs and m.rhs then
          vim.keymap.set(m.mode or 'n', m.lhs, m.rhs, m.opts or { silent = true })
        end
      end
    end
  end
end

apply_base()
apply_plugin_keymaps()

return M
