local M = {}

function M.setup()
  local ok, mason = pcall(require, 'mason')
  if not ok then return end

  mason.setup({
    ui = { border = 'rounded' },
  })

  local ok2, mlsp = pcall(require, 'mason-lspconfig')
  if not ok2 then return end

  mlsp.setup({
    ensure_installed = {
      'lua_ls', 'jsonls', 'yamlls', 'html', 'cssls',
      'pyright', 'gopls', 'bashls', 'marksman',
    },
    automatic_installation = true,
  })
end

return M
