-- Core commands for the current file's path.
local function current_file_paths()
    if vim.bo.buftype ~= "" then
        vim.notify("Current buffer is not a file", vim.log.levels.WARN)
        return
    end

    local name = vim.api.nvim_buf_get_name(0)
    if name == "" then
        vim.notify("Current buffer has no file path", vim.log.levels.WARN)
        return
    end

    local absolute = vim.fs.normalize(name)
    local cwd = vim.fs.normalize(vim.fn.getcwd())
    local cwd_parts = vim.split(cwd, "/", { plain = true, trimempty = true })
    local file_parts = vim.split(absolute, "/", { plain = true, trimempty = true })
    local common = 0

    while cwd_parts[common + 1] and cwd_parts[common + 1] == file_parts[common + 1] do
        common = common + 1
    end

    local parts = {}
    for _ = common + 1, #cwd_parts do
        parts[#parts + 1] = ".."
    end
    for i = common + 1, #file_parts do
        parts[#parts + 1] = file_parts[i]
    end

    return table.concat(parts, "/"), absolute
end

vim.api.nvim_create_user_command("ShowPath", function()
    local relative, absolute = current_file_paths()
    if not absolute then
        return
    end
    vim.api.nvim_echo({ { "Relative path: " .. relative .. "\nAbsolute path: " .. absolute } }, false, {})
end, { desc = "Show the current file's relative and absolute paths" })

local function copy_path(relative)
    local relative_path, absolute = current_file_paths()
    if not absolute then
        return
    end

    local target = relative and relative_path or absolute
    local ok, err = pcall(vim.fn.setreg, "+", target, "v")
    if not ok then
        vim.notify("Failed to copy path: " .. err, vim.log.levels.ERROR)
        return
    end
    vim.notify("Copied " .. (relative and "relative" or "absolute") .. " path: " .. target)
end

vim.api.nvim_create_user_command("CopyPath", function()
    copy_path(false)
end, { desc = "Copy the current file's absolute path to the system clipboard" })

vim.api.nvim_create_user_command("CopyRelativePath", function()
    copy_path(true)
end, { desc = "Copy the current file's relative path to the system clipboard" })
