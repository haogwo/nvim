# Neovim Configuration

This repository contains a modular and lazy-loaded Neovim configuration written in Lua. It is designed for performance, extensibility, and ease of use, with a focus on modern Neovim features.

## Features

- **Lazy Loading**: Plugins are loaded only when needed using [lazy.nvim](https://github.com/folke/lazy.nvim).
- **LSP Support**: Configured with `nvim-lspconfig` and `mason.nvim` for managing language servers.
- **Auto-completion**: Powered by `nvim-cmp` with support for LSP, buffer, path, and snippets.
- **UI Enhancements**: Rounded borders for floating windows, custom diagnostic signs, and severity-based highlights.
- **Virtual Environment Detection**: Automatically detects Python virtual environments for `pyright`.
- **Filetype-Specific Plugins**: Includes configurations for Git, Markdown, and more.

## Directory Structure

```
~/.config/nvim/
├── init.lua                # Entry point for Neovim configuration
├── lazy-lock.json          # Lockfile for lazy.nvim
├── lua/
│   ├── core/               # Core settings (options, autocmds, commands)
│   ├── keymaps/            # Key mappings
│   ├── plugins/            # Plugin configurations and specifications
│   │   ├── config/         # Plugin-specific configurations
│   │   │   ├── lsp/        # LSP-related configurations
│   │   │   ├── telescope.lua
│   │   │   ├── ...
│   │   ├── specs/          # Plugin specifications for lazy.nvim
│   │   │   ├── lsp.lua     # LSP plugin specifications
│   │   │   ├── ...
```

## Key Plugins

### Core Plugins
- **[lazy.nvim](https://github.com/folke/lazy.nvim)**: Plugin manager for lazy-loading.
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)**: Quickstart configurations for LSP.
- **[mason.nvim](https://github.com/williamboman/mason.nvim)**: LSP/DAP installer.
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)**: Auto-completion framework.

### UI Plugins
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)**: Fuzzy finder with rounded borders.
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)**: Statusline.
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)**: Git integration.

### LSP Plugins
- **[mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)**: Bridges `mason.nvim` and `nvim-lspconfig`.
- **[cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)**: LSP source for `nvim-cmp`.
- **[fidget.nvim](https://github.com/j-hui/fidget.nvim)**: LSP progress UI.

## Installation

1. Clone this repository into your Neovim configuration directory:
   ```bash
   git clone <repo-url> ~/.config/nvim
   ```

2. Open Neovim and install plugins:
   ```vim
   :Lazy sync
   ```

3. Restart Neovim to apply changes.

## Configuration Highlights

### LSP Configuration
- **Diagnostics**: Custom signs, severity-based highlights, and rounded borders for floating windows.
- **Python**: `pyright` is configured with workspace diagnostics and virtual environment detection.
- **Lua**: `lua_ls` includes Neovim-specific settings.

### Auto-completion
- **Sources**: LSP, buffer, path, and snippets.
- **Snippets**: Managed with `LuaSnip` and `friendly-snippets`.

### UI Enhancements
- **Rounded Borders**: Applied to diagnostics, hover, signature help, and Telescope.
- **Statusline**: Configured with `lualine.nvim`.

## Keymaps

- **Core keymaps**: Defined in `lua/keymaps/base.lua`. These are loaded early and enhance basic editing and navigation, for example:
   - `Ctrl-h/j/k/l`: Move between windows
   - `<leader>nh`: Clear search highlights
   - `Y` (visual): Yank to system clipboard
   - `J` / `K` (visual): Move selected lines up/down

- **Plugin keymaps**: Declared in `lua/keymaps/plugins.lua` and applied via `lua/keymaps/init.lua`. Common plugin mappings include:
   - `<leader>ff` / `<leader>fg` / `<leader>fb` / `<leader>fh`: Telescope find files / live grep / buffers / help tags
   - `<leader>gg`: Open Neogit status
   - `<leader>gd` / `<leader>gD` / `<leader>gc`: Diffview commands
   - `<M-e>` (Insert): Trigger autopairs fast wrap

- **LSP keymaps**: Buffer-local mappings are registered from `lspconfig.lua`'s `on_attach`. Typical mappings:
   - `<leader>gd`: Go to definition
   - `<leader>gr`: References
   - `<leader>gi`: Implementation
   - `<C-d>`: Hover

You can customize mappings by editing the above files. Each mapping entry includes a `desc` field for discoverability with which-key or similar plugins.

## LSP / Python (detailed)

- `pyright` is configured in `lua/plugins/config/lsp/lspconfig.lua` to enable workspace diagnostics and stronger analysis for typical Django/large projects.
- Virtual environment detection: the config attempts to use `$VIRTUAL_ENV` when present, otherwise it looks for project-local `.venv` or `venv` directories and sets `venvPath`/`venv` accordingly.

## Customizing mappings (examples)

You can customize or add mappings by editing the corresponding files in `lua/keymaps/`.

- Edit core mappings in `lua/keymaps/base.lua`:

```lua
-- change window navigation to use Alt + h/j/k/l
local map = function(mode, lhs, rhs, opts)
   opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
   vim.keymap.set(mode, lhs, rhs, opts)
end
map('n', '<A-h>', '<C-w>h')
map('n', '<A-j>', '<C-w>j')
```

- Add or modify plugin mappings in `lua/keymaps/plugins.lua` (entries include `mode`, `lhs`, `rhs`, `opts` with `desc`):

```lua
-- add a custom telescope mapping
table.insert(M.telescope, { lhs = '<leader>fp', rhs = function() require('telescope.builtin').grep_string() end, opts = { desc = 'telescope: grep string' } })
```

- LSP mappings are registered buffer-locally from `lua/plugins/config/lsp/lspconfig.lua` in the `on_attach` function. To change them, update the `keymaps.plugins` entries consumed during `on_attach`, or modify `on_attach` directly.

After editing, reload your configuration or restart Neovim. If you use `which-key.nvim`, ensure each mapping has a `desc` for discoverability.

## Contributing

Feel free to open issues or submit pull requests for improvements or bug fixes.

## License

This configuration is open-source and available under the MIT License.