local M = {
    treesitter_max_bytes = 1024 * 1024,
}

local languages = { "python", "go" }

-- Missing parsers are installed asynchronously; installed parsers are skipped.
require("nvim-treesitter").install(languages)

function M.allow_treesitter(bufnr)
    local bytes = vim.api.nvim_buf_get_offset(bufnr, vim.api.nvim_buf_line_count(bufnr))
    return bytes <= M.treesitter_max_bytes
end

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
    pattern = languages,
    callback = function(args)
        local language = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if M.allow_treesitter(args.buf) and language and vim.treesitter.language.add(language) then
            vim.treesitter.start(args.buf, language)
        end
    end,
})

return M
