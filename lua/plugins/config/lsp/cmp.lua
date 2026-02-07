local M = {}

function M.setup()
  local ok_cmp, cmp = pcall(require, 'cmp')
  if not ok_cmp then return end

  local ok_luasnip, luasnip = pcall(require, 'luasnip')
  if ok_luasnip then
    local ok_vs, vs_loader = pcall(require, 'luasnip.loaders.from_vscode')
    if ok_vs and vs_loader then
      vs_loader.lazy_load()
    end
  end

  local formatting = {}
  local ok_lspkind, lspkind = pcall(require, 'lspkind')
  if ok_lspkind then
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol_text',
        maxwidth = 50,
        ellipsis_char = '…',
      }),
    }
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        if ok_luasnip then
          luasnip.lsp_expand(args.body)
        end
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif ok_luasnip and luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif ok_luasnip and luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
      { name = 'path' },
    }),
    formatting = formatting,
    experimental = { ghost_text = true },
    window = {
      completion = cmp.config.window.bordered({
        border = 'rounded',
      }),
      documentation = cmp.config.window.bordered({
        border = 'rounded',
      }),
    },
    performance = {
      max_view_entries = 50,
    },
  })
end

return M
