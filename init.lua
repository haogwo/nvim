vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("core.keymaps")
require("core.commands")
require("core.autocmds")
require("core.options")

require("plugins")
require("plugins.theme")
require("plugins.treesitter")
require("plugins.rainbow")
require("plugins.hlchunk")
require("plugins.pairs")
require("plugins.statusline")
require("plugins.telescope")
require("plugins.todo_comments")
