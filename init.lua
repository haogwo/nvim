-- Leader keys must be set before plugins and keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Optional: enable Lua module loader cache (Neovim 0.9+)
pcall(function()
  if vim.loader and vim.loader.enable then
    vim.loader.enable()
  end
end)

-- Safe require helper to avoid startup errors when modules are missing
local function safe_require(mod)
  local ok, result = pcall(require, mod)
  if not ok then
    vim.schedule(function()
      pcall(vim.notify, string.format("[nvim] failed to load %s: %s", mod, result), vim.log.levels.WARN)
    end)
  end
  return ok and result or nil
end

-- Core (no plugin dependency)
safe_require("core.options")
safe_require("core.autocmds")
safe_require("core.commands")

-- Keymaps (centralized custom mappings)
safe_require("keymaps")

-- Plugins (lazy.nvim bootstrap and specs)
safe_require("plugins")
