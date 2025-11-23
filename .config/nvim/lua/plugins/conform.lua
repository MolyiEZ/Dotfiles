return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		format_after_save = {
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			luau = { "stylua" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			qml = { "qmlformat" },
			python = { "ruff_format" },
			json = { "prettierd", "prettier", "jq" },
			json5 = { "prettierd", "prettier" },
			jsonc = { "deno_fmt_jsonc", "dprint", "prettier" },
			rust = { "rustfmt" },
			markdown = { "prettier" },
		},
		formatters = {
			jq = {
				command = "jq",
				args = { "--indent", "4", "." }, -- 4 spaces, sort keys
				stdin = true,
			},
		},

		log_level = vim.log.levels.DEBUG,
	},
}
