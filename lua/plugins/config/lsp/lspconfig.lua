local M = {}

local function on_attach(client, bufnr)
  -- Buffer-local keymaps for LSP (loaded from keymaps registry)
  local maps = require('keymaps').for_plugin('lsp')
  for _, m in ipairs(maps) do
    local opts = vim.tbl_extend('force', { silent = true, buffer = bufnr }, m.opts or {})
    vim.keymap.set(m.mode or 'n', m.lhs, m.rhs, opts)
  end

  -- Optional: disable semantic tokens for performance on big files
  local ok_big, bigfile = pcall(require, 'core.bigfile')
  if ok_big and bigfile.is_bigfile(bufnr) then
    if client.server_capabilities and client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end
end

local function capabilities()
  local caps = vim.lsp.protocol.make_client_capabilities()
  local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  if ok_cmp and cmp_lsp and cmp_lsp.default_capabilities then
    caps = cmp_lsp.default_capabilities(caps)
  end
  return caps
end

local function setup_servers()
  local lsp = vim.lsp

  -- Diagnostics UI
  vim.diagnostic.config({
    virtual_text = { spacing = 2, prefix = '●' },
    float = { border = 'rounded' },
    signs = {
      -- Enable signs in the sign column (default: true)
      active = true,

      -- Define the text (icon) shown for each severity level
      text = {
        [vim.diagnostic.severity.ERROR] = " ",  -- or your preferred icon
        [vim.diagnostic.severity.WARN]  = " ",
        [vim.diagnostic.severity.INFO]  = " ",
        [vim.diagnostic.severity.HINT]  = "💡",  -- common alternatives: " ", " ", etc.
      },

      -- Optional: Apply line highlighting based on severity
      linehl = {
        [vim.diagnostic.severity.ERROR] = "Error",
        [vim.diagnostic.severity.WARN]  = "Warn",
        [vim.diagnostic.severity.INFO]  = "Info",
        [vim.diagnostic.severity.HINT]  = "Hint",
      },

    },
    underline = true,
    severity_sort = true,
    update_in_insert = false,
  })

  -- Rounded borders for LSP hover/signature windows
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

  -- Helper to register and enable a server via the new vim.lsp.config API
  local function cfg(name, extra)
    local opts = vim.tbl_deep_extend('force', { on_attach = on_attach, capabilities = capabilities() }, extra or {})
    vim.lsp.config(name, opts)
    -- Enable the config so it activates for its filetypes
    vim.lsp.enable(name)
  end

  -- Lua LS
  cfg('lua_ls', {
    settings = {
      Lua = {
        diagnostics = { globals = { 'vim' } },
        workspace = { checkThirdParty = false },
        hint = { enable = true },
      },
    },
  })

  -- JSON
  cfg('jsonls')

  -- YAML
  cfg('yamlls')

  -- HTML / CSS
  cfg('html')
  cfg('cssls')

  -- Python (Pyright) — enable workspace diagnostics and venv auto-detection
  cfg('pyright', {
    on_new_config = function(new_config, new_root)
      new_config.settings = new_config.settings or {}
      new_config.settings.python = new_config.settings.python or {}

      -- Detect virtual environment
      local venv = vim.env.VIRTUAL_ENV
      if venv and #venv > 0 then
        new_config.settings.python.venvPath = vim.fn.fnamemodify(venv, ':h')
        new_config.settings.python.venv = vim.fn.fnamemodify(venv, ':t')
      else
        -- Fallback to project-local .venv/ or venv/
        local candidates = { '.venv', 'venv' }
        for _, name in ipairs(candidates) do
          local candidate = new_root .. '/' .. name
          if vim.fn.isdirectory(candidate) == 1 then
            new_config.settings.python.venvPath = new_root
            new_config.settings.python.venv = name
            break
          end
        end
      end

      -- Strengthen analysis for Django/projects
      new_config.settings.python.analysis = vim.tbl_deep_extend('force', {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
        autoImportCompletions = true,
      }, new_config.settings.python.analysis or {})
    end,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'workspace',
          autoImportCompletions = true,
        },
      },
    },
  })

  -- Go
  cfg('gopls', {
    settings = {
      gopls = {
        analyses = { unusedparams = true },
        staticcheck = true,
      },
    },
  })

  -- Bash
  cfg('bashls')

  -- Markdown
  cfg('marksman')
end

function M.setup()
  setup_servers()
end

return M
