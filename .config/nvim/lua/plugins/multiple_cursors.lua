return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		local set = vim.keymap.set

		-- Add or skip cursor above/below the main cursor.
		set({ "n", "x" }, "<A-k>", function()
			mc.lineAddCursor(-1)
		end)
		set({ "n", "x" }, "<A-j>", function()
			mc.lineAddCursor(1)
		end)

		-- Add or skip adding a new cursor by matching word/selection
		set({ "n", "x" }, "<A-n>", function()
			mc.matchAddCursor(1)
		end)
		set({ "n", "x" }, "<A-s>", function()
			mc.matchSkipCursor(1)
		end)
		set({ "n", "x" }, "<A-N>", function()
			mc.matchAddCursor(-1)
		end)
		set({ "n", "x" }, "<A-S>", function()
			mc.matchSkipCursor(-1)
		end)

		-- Add and remove cursors with control + left click.
		set("n", "<c-leftmouse>", mc.handleMouse)
		set("n", "<c-leftdrag>", mc.handleMouseDrag)
		set("n", "<c-leftrelease>", mc.handleMouseRelease)

		-- Disable and enable cursors.
		set({ "n", "x" }, "<A-c>", mc.toggleCursor)

		-- Mappings defined in a keymap layer only apply when there are
		-- multiple cursors. This lets you have overlapping mappings.
		mc.addKeymapLayer(function(layerSet)
			-- Select a different cursor as the main one.
			layerSet({ "n", "x" }, "<A-u>", mc.prevCursor)
			layerSet({ "n", "x" }, "<A-d>", mc.nextCursor)

			-- Delete the main cursor.
			layerSet({ "n", "x" }, "<A-x>", mc.deleteCursor)

			-- Enable and clear cursors using escape.
			layerSet("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end)
		end)

		-- Customize how cursors look.
		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { reverse = true })
		hl(0, "MultiCursorVisual", { link = "Visual" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorMatchPreview", { link = "Search" })
		hl(0, "MultiCursorDisabledCursor", { reverse = true })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
	end,
}

-- return {
-- 	"brenton-leighton/multiple-cursors.nvim",
-- 	version = "*",
-- 	opts = {
-- 		pre_hook = function()
-- 			vim.cmd("set nocul")
-- 			vim.cmd("NoMatchParen")
-- 		end,
-- 		post_hook = function()
-- 			vim.cmd("set cul")
-- 			vim.cmd("DoMatchParen")
-- 		end,
-- 	},
-- 	keys = {
-- 		{ "<A-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n" }, desc = "Add a cursor then move down" },
-- 		{ "<A-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n" }, desc = "Add a cursor then move up" },
-- 		{
-- 			"<A-LeftMouse>",
-- 			"<Cmd>MultipleCursorsMouseAddDelete<CR>",
-- 			mode = { "n", "i" },
-- 			desc = "Add or remove a cursor",
-- 		},
-- 		{
-- 			"<A-a>",
-- 			"<Cmd>MultipleCursorsAddMatches<CR>",
-- 			mode = { "n", "x" },
-- 			desc = "Add cursors to the word under the cursor",
-- 		},
-- 		{
-- 			"<A-d>",
-- 			"<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
-- 			mode = { "n", "x" },
-- 			desc = "Add cursor and jump to next cword",
-- 		},
-- 		{ "<A-D>", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = { "n", "x" }, desc = "Jump to next cword" },
-- 		{
-- 			"<A-u>",
-- 			"<Cmd>MultipleCursorsAddJumpPrevMatch<CR>",
-- 			mode = { "n", "x" },
-- 			desc = "Add cursor and jump to prev cword",
-- 		},
-- 		{ "<A-U>", "<Cmd>MultipleCursorsJumpPrevMatch<CR>", mode = { "n", "x" }, desc = "Jump to prev cword" },
-- 	},
-- }
