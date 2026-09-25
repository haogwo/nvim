local M = {
    treesitter_max_bytes = 1024 * 1024,
}

function M.allow_treesitter(bufnr)
    local bytes = vim.api.nvim_buf_get_offset(bufnr, vim.api.nvim_buf_line_count(bufnr))
    return bytes <= M.treesitter_max_bytes
end

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
    pattern = "python",
    callback = function(args)
        if M.allow_treesitter(args.buf) and vim.treesitter.language.add("python") then
            vim.treesitter.start(args.buf, "python")
        end
    end,
})

return M
