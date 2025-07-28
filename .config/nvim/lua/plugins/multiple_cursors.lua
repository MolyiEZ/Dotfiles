return {
	"brenton-leighton/multiple-cursors.nvim",
	version = "*",
	opts = {
		pre_hook = function()
			vim.cmd("set nocul")
			vim.cmd("NoMatchParen")
		end,
		post_hook = function()
			vim.cmd("set cul")
			vim.cmd("DoMatchParen")
		end,
	},
	keys = {
		{ "<A-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n" }, desc = "Add a cursor then move down" },
		{ "<A-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n" }, desc = "Add a cursor then move up" },
		{
			"<A-LeftMouse>",
			"<Cmd>MultipleCursorsMouseAddDelete<CR>",
			mode = { "n", "i" },
			desc = "Add or remove a cursor",
		},
		{
			"<A-a>",
			"<Cmd>MultipleCursorsAddMatches<CR>",
			mode = { "n", "x" },
			desc = "Add cursors to the word under the cursor",
		},
		{
			"<A-d>",
			"<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
			mode = { "n", "x" },
			desc = "Add cursor and jump to next cword",
		},
		{ "<A-D>", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = { "n", "x" }, desc = "Jump to next cword" },
		{
			"<A-u>",
			"<Cmd>MultipleCursorsAddJumpPrevMatch<CR>",
			mode = { "n", "x" },
			desc = "Add cursor and jump to prev cword",
		},
		{ "<A-U>", "<Cmd>MultipleCursorsJumpPrevMatch<CR>", mode = { "n", "x" }, desc = "Jump to prev cword" },
	},
}
