-- Bootstrap lazy.nvim and load plugin specs
local M = {}

local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
	vim.schedule(function()
		pcall(vim.notify, "[nvim] lazy.nvim failed to load", vim.log.levels.ERROR)
	end)
	return M
end

lazy.setup({
	spec = {
		{ import = "plugins.specs" }, -- import all specs under this directory
	},
	defaults = {
		lazy = true,      -- enable lazy-loading by default
		version = false,  -- always use latest commit (pin with lazy-lock.json later)
	},
	install = { colorscheme = { "everforest" } },
	checker = { enabled = true, notify = false },
	change_detection = { notify = false },
	ui = { border = "rounded" },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"zipPlugin",
				"matchparen",
				"matchit",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
			},
		},
	},
})

return M
