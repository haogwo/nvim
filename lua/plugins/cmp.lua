return {
  {
    "hrsh7th/nvim-cmp",
    -- 核心修复：与 LSP 同步加载，弃用容易引发竞争的 "InsertEnter"
    event = { "InsertEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- 获取来自 Basedpyright 等服务器的数据
      "hrsh7th/cmp-buffer",   -- 当前文档中的可用词汇补全
      "hrsh7th/cmp-path",     -- 系统文件路径补全
      "L3MON4D3/LuaSnip",     -- 核心片段解析与扩展引擎
      "saadparwaiz1/cmp_luasnip", -- 桥接 LuaSnip 与 nvim-cmp
      "rafamadriz/friendly-snippets", -- 通用 Snippets 库
      "onsails/lspkind-nvim",  -- 提示符号
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      -- 解析并加载 VS Code 风格的代码片段包
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        -- 补全窗口边框为圆角
        window = {
          completion = cmp.config.window.bordered({border = 'rounded'}),
          documentation = cmp.config.window.bordered({border = 'rounded'}),
        },
        formatting = {
           format = lspkind.cmp_format({
             mode = 'symbol',  -- 显示图标+文本
             maxwidth = 50,    -- 限制补全项宽度
           })
        },

        --- 定义补全快捷键
        mapping = cmp.mapping.preset.insert(
          {
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = cmp.mapping(
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif ok_luasnip and luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end,
              { 'i', 's' }
            ),
            ['<S-Tab>'] = cmp.mapping(
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif ok_luasnip and luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end,
              { 'i', 's' }
            ),
        }),

        -- 定义最终展示候选项的数据来源及其权重排序
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }),
      })
    end,
  },
}

