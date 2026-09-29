local severity = vim.diagnostic.severity
local palette = require("xuantong.palette")

local underline_colors = {
  Error = palette.ansi[2],
  Warn = palette.ansi[4],
  Info = palette.ansi[7],
  Hint = palette.ansi[5],
}

local function apply_diagnostic_undercurls()
  for level, color in pairs(underline_colors) do
    vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. level, { undercurl = true, sp = color })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("user_diagnostic_undercurls", { clear = true }),
  callback = apply_diagnostic_undercurls,
})
apply_diagnostic_undercurls()

vim.diagnostic.config({
  signs = {
    text = {
      [severity.ERROR] = " ",
      [severity.WARN] = " ",
      [severity.INFO] = " ",
      [severity.HINT] = "󰌵 ",
    },
  },
  virtual_text = { prefix = "●", spacing = 2 },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded" },
})

vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lsp", { clear = true }),
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show hover documentation" }))
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find references" }))
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostics" }))
  end,
})

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "basedpyright", "gopls", "jsonls", "lua_ls" },
  automatic_enable = { "basedpyright", "gopls", "jsonls", "lua_ls" },
})
