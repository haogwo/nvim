vim.api.nvim_create_user_command('ShowPath', function()
    local path = vim.fn.expand('%:p')
    print(path)
end, {})

vim.api.nvim_create_user_command('CopyPath', function()
    local path = vim.fn.expand('%:p')
    vim.fn.setreg('+', path)
    print('Path (' .. path .. ') has been copied to clipboard')
end, {})

vim.api.nvim_create_user_command('CopyRelativePath', function()
    local relative_path = vim.fn.expand('%')
    vim.fn.setreg('+', relative_path)
    print('Path (' .. relative_path .. ') has been copied to clipboard')
end, {})

