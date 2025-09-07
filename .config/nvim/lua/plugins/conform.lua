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
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			qml = { "qmlformat" },
			python = { "ruff_format" },
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
		},

		log_level = vim.log.levels.DEBUG,
	},
}
