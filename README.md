# Neovim 配置

配置入口是 `init.lua`。`lua/core/` 放不依赖额外插件的编辑器功能，
`lua/plugins/` 放插件安装与插件配置。

- `lua/core/options.lua`：编辑器选项、剪贴板提供器和持久化文件目录
- `lua/core/keymaps.lua`：通用键位
- `lua/core/commands.lua`：自定义路径命令
- `lua/core/autocmds.lua`：外部变更检测与光标位置恢复
- `lua/plugins/init.lua`：通过 `vim.pack` 安装插件
- `lua/plugins/theme.lua`：「玄同」主题
- `lua/plugins/treesitter.lua`：Python Tree-sitter 高亮及共用的文件大小阈值
- `lua/plugins/rainbow.lua`：彩虹括号颜色与启用条件
- `lua/plugins/hlchunk.lua`：代码块边框和块内行号
- `lua/plugins/pairs.lua`：自动补全括号和引号
- `lua/plugins/statusline.lua`：lualine 状态栏和顶部 buffer/tab 栏
- `lua/plugins/telescope.lua`：文件查找、内容搜索与目录浏览
- `lua/plugins/todo_comments.lua`：TODO 等注释标记高亮和检索

当前文件在磁盘上被外部程序修改后，Neovim 会在重新获得焦点或最多约 2 秒内自动重读；
缓冲区有未保存修改时不会自动覆盖。
重新打开文件时，光标会回到上次离开的位置（使用 Neovim 的 ShaDa 记录）。

用可视模式选中文本后按 `Y` 复制到系统剪贴板；`y` 保持原有的 Neovim 复制行为。
tmux 会话使用内置剪贴板提供器；不经过 tmux 的 SSH 会话使用 OSC 52。
这两种情况都要求本地终端允许 OSC 52 写入；本地且不使用 tmux 时，
Neovim 自动选择可用的系统剪贴板提供器。

路径命令以当前 `:pwd` 为相对路径基准：`:ShowPath` 显示当前文件的相对路径和
绝对路径；`:CopyPath` 复制绝对路径到系统剪贴板；
`:CopyRelativePath` 复制相对路径。未命名缓冲区和非文件缓冲区不处理。

顶部显示 buffer 和 tab；每个窗口的状态栏显示模式、Git 分支及改动、
诊断、文件名、编码、换行格式、文件类型、进度和光标位置。状态栏使用「玄同」调色板。

彩虹括号使用 `rainbow-delimiters.nvim`，颜色来自「玄同」调色板；超过大小阈值的缓冲区不启用。
对应语言需要先安装 Tree-sitter 解析器，目前 Python 已配置。

`hlchunk.nvim` 显示代码块边框和块内行号，沿用 1 MiB 的 Tree-sitter 大小阈值。
`todo-comments.nvim` 高亮 TODO、FIX、HACK 等注释；可用 `:TodoTelescope` 搜索项目注释。

插入模式下，`mini.pairs` 自动补全 `()`、`[]`、`{}`、引号和反引号。

Telescope 使用 `<leader>ff` 查找文件、`<leader>fg` 搜索内容、`<leader>fb` 切换缓冲区、
`<leader>fh` 查找帮助、`<leader>fe` 从当前文件目录开始浏览。文件浏览器和 fzf 排序扩展已启用。

「玄同」是[独立主题项目](https://github.com/haogwo/xuantong)，包含自己的配色入口、
调色板、Python 高亮模块和验证脚本。当前配置通过 `vim.pack` 从 GitHub 安装。

Python 使用 `nvim-treesitter` 提供的解析器和查询文件，并通过 Neovim 内置的
Tree-sitter 高亮。首次安装插件后执行 `:TSInstall python`，再重新打开 Python 文件。
超过大小阈值的 Python 缓冲区保留传统语法高亮，不启动 Tree-sitter。
统一阈值在 `lua/plugins/treesitter.lua` 中设置，当前为 1 MiB。
主题为 Python 单独区分普通变量、参数、成员、函数和模块；其他语言沿用
原来的 Vim 配色。插件自身的使用和验证方法见其 GitHub 仓库。
