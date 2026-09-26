# Neovim 配置

配置入口是 `init.lua`。`lua/core/` 放不依赖额外插件的编辑器功能，
`lua/plugins/` 放插件安装与插件配置。

- `lua/core/options.lua`：编辑器选项、剪贴板提供器和持久化文件目录
- `lua/core/keymaps.lua`：通用键位
- `lua/core/commands.lua`：自定义路径命令
- `lua/core/autocmds.lua`：外部变更检测与光标位置恢复
- `lua/plugins/init.lua`：通过 `vim.pack` 安装插件
- `lua/plugins/theme.lua`：「玄同」主题
- `lua/plugins/treesitter.lua`：Python、Go Tree-sitter 高亮及共用的文件大小阈值
- `lua/plugins/rainbow.lua`：彩虹括号颜色与启用条件
- `lua/plugins/hlchunk.lua`：代码块边框和块内行号
- `lua/plugins/pairs.lua`：自动补全括号和引号
- `lua/plugins/statusline.lua`：lualine 状态栏和顶部 buffer/tab 栏
- `lua/plugins/telescope.lua`：文件查找、内容搜索与目录浏览
- `lua/plugins/todo_comments.lua`：TODO 等注释标记高亮和检索
- `lua/plugins/completion.lua`：自动补全菜单、文档预览和函数签名
- `lua/plugins/lsp.lua`：语言服务器安装、诊断图标与 LSP 按键
- `lsp/`：各语言服务器的独立设置

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
Python 和 Go 的 Tree-sitter 解析器会自动安装；其他语言需要另行配置。

`hlchunk.nvim` 显示代码块边框和块内行号，沿用 1 MiB 的 Tree-sitter 大小阈值。
`todo-comments.nvim` 高亮 TODO、FIX、HACK 等注释；可用 `:TodoTelescope` 搜索项目注释。

插入模式下，`nvim-autopairs` 自动补全 `()`、`[]`、`{}`、引号和反引号，
也支持 Python 的三重单引号和三重双引号。在三引号之间按 Enter 会留出正文行；
若引号跟在代码之后，正文缩进一级，闭合引号与语句起始列对齐。三引号内继续换行时保留正文缩进。

Telescope 使用 `<leader>ff` 查找文件、`<leader>fg` 搜索内容、`<leader>fb` 切换缓冲区、
`<leader>fh` 查找帮助、`<leader>fe` 从当前文件目录开始浏览。文件浏览器和 fzf 排序扩展已启用。

LSP 使用 Neovim 内置客户端。Mason 首次启动时安装 Python 的 basedpyright、
Go 的 gopls、JSON 的 jsonls 和 Lua 的 lua-language-server；安装状态可通过 `:Mason` 查看。
`blink.cmp` 在插入模式提供补全：`<C-Space>` 打开菜单，`<Tab>` / `<S-Tab>` 选择候选项
或跳转片段占位符，`<CR>` / `<C-y>` 接受候选项，`<C-e>` 取消补全，
`<C-b>` / `<C-f>` 滚动文档。`K` 查看悬浮信息，`gd` 跳转定义，`gr` 查看引用，
`<leader>ca` 执行代码操作，`<leader>rn` 重命名符号，`<leader>e` 查看当前行诊断。
补全菜单、文档预览和函数签名窗口都使用圆角边框。
错误、警告、信息和提示分别显示诊断图标，状态栏汇总诊断数量。
JSON 由 SchemaStore 提供常见文件的 Schema；Go 补全启用参数占位符。
Lua 使用 LuaJIT 运行时，并索引 Neovim 的运行时文件；单个 Lua 文件也能获得诊断，
项目自己的 `.luarc.json` 设置仍优先。
gopls 的安装需要本机有 Go 工具链，jsonls 需要 Node.js/npm，basedpyright 需要 Python 包安装环境。

「玄同」是[独立主题项目](https://github.com/haogwo/xuantong)，包含自己的配色入口、
调色板、Python 高亮模块和验证脚本。当前配置通过 `vim.pack` 从 GitHub 安装。

Python 和 Go 使用 `nvim-treesitter` 提供的解析器和查询文件，并通过 Neovim 内置的
Tree-sitter 高亮。首次安装解析器完成后，重新打开对应文件即可启用。
超过大小阈值的缓冲区保留传统语法高亮，不启动 Tree-sitter。
统一阈值在 `lua/plugins/treesitter.lua` 中设置，当前为 1 MiB。
主题为 Python 单独区分普通变量、参数、成员、函数和模块；其他语言沿用
原来的 Vim 配色。插件自身的使用和验证方法见其 GitHub 仓库。
