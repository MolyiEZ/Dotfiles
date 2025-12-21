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
				autogenerate = false,
				rojo_project_file = "default.project.json",
				sourcemap_file = "sourcemap.json",
			},
			fflags = {
				enable_new_solver = false,
				sync = false,
			},
		})
	end,
}
