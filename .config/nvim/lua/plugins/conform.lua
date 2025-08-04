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
			qml = { "qmlformat" },
			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },
			--
			-- You can use 'stop_after_first' to run the first available formatter from the list
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
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
