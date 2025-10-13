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
			sourcemap = {
				enabled = true,
				autogenerate = true, -- automatic generation when the server is initialized
				rojo_project_file = "default.project.json",
				sourcemap_file = "sourcemap.json",
			},
			plugin = {
				enabled = true,
			},
		})
	end,
}
