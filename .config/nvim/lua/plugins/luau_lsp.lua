return {
	"lopi-py/luau-lsp.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		vim.lsp.config("luau-lsp", {
			settings = {
				["luau-lsp"] = {
					completion = {
						imports = {
							enabled = true,
						},
					},
				},
			},
		})

		require("luau-lsp").setup({
			plugin = {
				enabled = true,
			},
		})
	end,
}
