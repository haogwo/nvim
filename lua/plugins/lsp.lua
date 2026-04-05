return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- 自动化安装依赖的二进制包
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- 解决 cmp 加载报错的核心：强制在 LSP 初始化前加载补全主引擎，防止依赖断层
      "hrsh7th/nvim-cmp",
      -- 声明补全引擎的 capabilities，告知 LSP 客户端支持哪些高级特性（如代码片段展开）
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- 初始化 Mason
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      local mason_lspconfig = require("mason-lspconfig")

      -- 确保目标服务器被自动安装 (专注后端栈)
      mason_lspconfig.setup({
        ensure_installed = {
          -- LSP
          "basedpyright",   -- 现代 Python 核心
          "lua_ls",         -- Neovim 配置支持
          "vue-language-server", -- Vue SFC 支持
        },
      })

      -- Diagnostics UI
      vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" },
        float = {
          border = "rounded",
          source = "always",
        },
        signs = {
          -- Enable signs in the sign column (default: true)
          active = true,

          -- Define the text (icon) shown for each severity level
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
            [vim.diagnostic.severity.HINT]  = "💡",
          },

          -- Optional: Apply line highlighting based on severity
          linehl = {
            [vim.diagnostic.severity.ERROR] = "Error",
            [vim.diagnostic.severity.WARN] = "Warn",
            [vim.diagnostic.severity.INFO] = "Info",
            [vim.diagnostic.severity.HINT] = "Hint",
          },
        },
        underline = true,
        severity_sort = true,
        update_in_insert = false,
      })

      -- Rounded borders for LSP hover/signature windows
      vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
        vim.lsp.handlers.hover(err, result, ctx, vim.tbl_extend("force", config or {}, { border = "rounded" }))
      end
      vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
        vim.lsp.handlers.signature_help(err, result, ctx, vim.tbl_extend("force", config or {}, { border = "rounded" }))
      end

      -- 获取补全引擎广播的默认能力集
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      ---------------------------------------------------------
      -- Python (Basedpyright) 配置 (采用 v0.11+ 原生 API)
      ---------------------------------------------------------
      vim.lsp.config("basedpyright", {
        capabilities = capabilities,
        settings = {
          basedpyright = {
            analysis = {
              -- 配置类型检查严格度，"standard" 在不报无效错误的前提下提供极佳的保护
              typeCheckingMode = "standard",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              -- 仅针对打开的文件进行诊断，避免大型 Django 项目导致的性能瘫痪
              diagnosticMode = "openFilesOnly",
              -- 启用内联参数提示 (如 foo(param1=bar))
              inlayHints = {
                callArgumentNames = true,
              },
            },
          },
        },
      })
      ---------------------------------------------------------
      -- Lua LSP，识别Neovim环境
      ---------------------------------------------------------
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
      ---------------------------------------------------------
      -- Vue (Volar v2)
      ---------------------------------------------------------
      vim.lsp.config("volar", {
        capabilities = capabilities,
        filetypes = { "vue" },
        init_options = {
          typescript = {
            tsdk = vim.fn.expand(
            "$HOME/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib"),
          },
        },
      })

      -- 启动目标 LSP
      vim.lsp.enable("basedpyright")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("volar")

      ---------------------------------------------------------
      -- 全局 LSP 快捷键映射 (仅在 LSP 附加到缓冲区时生效)
      ---------------------------------------------------------
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          -- 悬停查看函数或类的文档
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          -- 跳转到定义
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          -- 查看引用
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          -- 执行代码快速修复 (例如导入缺失的包)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          -- 重命名符号 (同步重命名所有引用)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          -- 手动触发浮窗查看当前行诊断
          vim.keymap.set(
            "n",
            "<leader>e",
            vim.diagnostic.open_float,
            { desc = "显示当前行完整错误" }
          )

          -- 启用内置 inlay hints
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
          end
        end,
      })
    end,
  },
}
