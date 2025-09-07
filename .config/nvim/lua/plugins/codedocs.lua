return {
	"danymat/neogen",
	config = function()
		require("neogen").setup({
			snippet_engine = "luasnip", -- choose your snippet tool
			languages = {
				typescript = {
					template = {
						type = {
							annotation_convention = "TSDoc",
						},
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>ng", require("neogen").generate, { desc = "Document [N]eo[G]en" })
		vim.keymap.set("i", "<C-l>", require("neogen").jump_next, { desc = "Next snippet" })
		vim.keymap.set("i", "<C-h>", require("neogen").jump_prev, { desc = "Prev snippet" })
	end,
}
