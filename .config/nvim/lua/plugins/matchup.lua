return {
	"andymass/vim-matchup",

	---@type matchup.Config
	config = function()
		require("match-up").setup({
			treesitter = {
				stopline = 500,
			},
		})

		vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end,
}
