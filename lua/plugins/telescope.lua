local telescope = require("telescope")

telescope.setup({
    defaults = {
        prompt_prefix = "❯ ",
        selection_caret = " ",
        color_devicons = true,
    },
})

telescope.load_extension("file_browser")

local ok, err = pcall(telescope.load_extension, "fzf")
if not ok then
    vim.notify("Telescope fzf extension unavailable: " .. err, vim.log.levels.WARN)
end

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
vim.keymap.set("n", "<leader>fe", function()
    local name = vim.api.nvim_buf_get_name(0)
    local path = name ~= "" and vim.fs.dirname(name) or vim.fn.getcwd()
    telescope.extensions.file_browser.file_browser({ path = path, select_buffer = true })
end, { desc = "Browse files" })
