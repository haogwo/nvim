vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("jsonls")


vim.diagnostic.config({
  signs = {
    -- Enable signs in the sign column (default: true)
    active = true,

    -- Define the text (icon) shown for each severity level
    text = {
      [vim.diagnostic.severity.ERROR] = " ",  -- or your preferred icon
      [vim.diagnostic.severity.WARN]  = " ",
      [vim.diagnostic.severity.INFO]  = " ",
      [vim.diagnostic.severity.HINT]  = "󰠠 ",  -- common alternatives: " ", " ", etc.
    },

    -- Optional: Apply line highlighting based on severity
    linehl = {
      [vim.diagnostic.severity.ERROR] = "Error",
      [vim.diagnostic.severity.WARN]  = "Warn",
      [vim.diagnostic.severity.INFO]  = "Info",
      [vim.diagnostic.severity.HINT]  = "Hint",
    },

  },
  -- Other common diagnostic options (recommended defaults)
  virtual_text = false,          -- disable inline virtual text by default
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- 放在 init.lua 或 plugins/lsp.lua 等合适的位置
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- 安全检查：确保客户端支持 definition 功能
    if not client or not client.supports_method("textDocument/definition") then
      return
    end

    -- 常用映射（buffer-local，只在当前 buffer 生效）
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, {
      desc = "LSP: 跳转到定义"
    }))

    -- 建议一起设置的常用跳转键（可按需增删）
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration,     vim.tbl_extend("force", opts, { desc = "LSP: 跳转到声明" }))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation,  vim.tbl_extend("force", opts, { desc = "LSP: 跳转到实现" }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references,      vim.tbl_extend("force", opts, { desc = "LSP: 查找引用" }))
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "LSP: 跳转到类型定义" }))

    -- 其他常用功能
    vim.keymap.set("n", "K",  vim.lsp.buf.hover,           vim.tbl_extend("force", opts, { desc = "LSP: 悬浮文档" }))
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "LSP: 代码操作" }))
  end,
  desc = "LSP: 设置快捷键（仅在 LSP 附加时生效）",
})
