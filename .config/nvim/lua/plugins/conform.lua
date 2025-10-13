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
			json = { "prettierd", "prettier", "jq" }, -- fast → standard → rock-solid
			json5 = { "prettierd", "prettier" }, -- jq doesn’t support JSON5
			jsonc = { "deno_fmt_jsonc", "dprint", "prettier" },
		},
		formatters = {
			qmlformat = {
				command = "/usr/lib/qt6/bin/qmlformat",
				args = {
					"-w",
					"2", -- indent with 2 spaces
					"-W",
					"100", -- wrap lines at 100 characters
					"--objects-spacing", -- newline around object blocks
					"--functions-spacing", -- clearer spacing for JS functions
					"$FILENAME",
				},
			},
			jq = {
				command = "jq",
				args = { "--indent", "4", "." }, -- 4 spaces, sort keys
				stdin = true,
			},
		},

		log_level = vim.log.levels.DEBUG,
	},
}
