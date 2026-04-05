return {
	{
		"stevearc/conform.nvim",
		cmd = "Format",
		opts = {
			-- 不在保存时自动格式化，改为手动触发
			format_on_save = false,
			notify_on_error = true,
			formatters_by_ft = {
				lua = { "stylua" },
				json = { "biome", "prettier", "jq", stop_after_first = true },
				jsonc = { "biome", "prettier" }, -- 处理带注释的 JSON
				yaml = { "yamlfmt" },
				html = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
			vue = { "prettierd", "prettier" },
				markdown = { "prettierd", "prettier" },
				go = { "gofumpt", "goimports" },
				sh = { "shfmt" },
				sql = { "sqlfluff" },
			},
			formatters = {
				sqlfluff = {
					args = { "format", "--dialect", "mysql", "-" },
				},
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)

			-- Custom Command to conform buffer code
			vim.api.nvim_create_user_command("Format", function()
				require("conform").format({ async = true, lsp_fallback = true })
			end, { desc = "Format current buffer" })
		end,
	},
}
