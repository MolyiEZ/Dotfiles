return {
	"Mofiqul/vscode.nvim",
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		local c = require("vscode.colors").get_colors()
		require("vscode").setup({
			-- Alternatively set style in setup
			-- style = 'light'

			-- Enable transparent background
			transparent = true,

			-- Enable italic comment
			italic_comments = true,

			-- Underline `@markup.link.*` variants
			underline_links = true,

			-- Disable nvim-tree background color
			disable_nvimtree_bg = true,

			-- Apply theme colors to terminal
			terminal_colors = true,

			-- Override colors (see ./lua/vscode/colors.lua)
			color_overrides = {
				vscFront = "#E0E0E0",
				vscBack = "#1F1F1F",

				vscTabCurrent = "#1F1F1F",
				vscTabOther = "#2D2D2D",
				vscTabOutside = "#252526",

				vscLeftDark = "#252526",
				vscLeftMid = "#3B3B3B",
				vscLeftLight = "#73737A",

				vscPopupFront = "#CCCCCC",
				vscPopupBack = "#202020",
				vscPopupHighlightBlue = "#065B8D",
				vscPopupHighlightGray = "#434A51",

				vscSplitLight = "#A1A1A1",
				vscSplitDark = "#505050",
				vscSplitThumb = "#4D4D4D",

				vscCursorDarkDark = "#282828",
				vscCursorDark = "#5F5D5C",
				vscCursorLight = "#C2C4C2",
				vscSelection = "#2F64A0",
				vscLineNumber = "#6A6A6A",

				vscDiffRedDark = "#5A1212",
				vscDiffRedLight = "#951010",
				vscDiffRedLightLight = "#FF1C1C",
				vscDiffGreenDark = "#3F4826",
				vscDiffGreenLight = "#5C6E2E",
				vscSearchCurrent = "#596779",
				vscSearch = "#763919",

				vscGitAdded = "#76D292",
				vscGitModified = "#F2B457",
				vscGitDeleted = "#E0412C",
				vscGitRenamed = "#63E4A0",
				vscGitUntracked = "#63E4A0",
				vscGitIgnored = "#A0A0A0",
				vscGitStageModified = "#F2B457",
				vscGitStageDeleted = "#E0412C",
				vscGitConflicting = "#F55056",
				vscGitSubmodule = "#74C3F5",

				vscContext = "#4A4A4A",
				vscContextCurrent = "#808080",

				vscFoldBackground = "#25364A",

				vscSuggestion = "#7A7A7A",

				-- Syntax colors
				vscGray = "#999999",
				vscViolet = "#7C7DC5",
				vscBlue = "#60B5FF",
				vscAccentBlue = "#55C4FA",
				vscDarkBlue = "#205073",
				vscMediumBlue = "#00B6FF",
				vscDisabledBlue = "#7FB4D4",
				vscLightBlue = "#91DDFF",
				vscGreen = "#7FCF60",
				vscBlueGreen = "#63FFD0",
				vscLightGreen = "#C7F0B4",
				vscRed = "#FF3B3B",
				vscOrange = "#FFAC7B",
				vscLightRed = "#F47A7A",
				vscYellowOrange = "#FFCD83",
				vscYellow = "#F7ECB2",
				vscDarkYellow = "#FFD602",
				vscPink = "#EB8AE1",

				vscDimHighlight = "#5F5D5C",
			},

			-- Override highlight groups (see ./lua/vscode/theme.lua)
			group_overrides = {
				-- this supports the same val table as vim.api.nvim_set_hl
				-- use colors from this colorscheme by requiring vscode.colors!
				Cursor = { fg = "#ffffff", bg = "#ffffff", bold = true },
				CursorLineNr = { fg = "#ffffff" },
				DiagnosticHint = { fg = "#EAFF94" },
				Comment = { fg = "#63676E" },
				["@comment"] = { fg = "#63676E", italic = true },
				["@variable.parameter"] = { fg = c.vscLightRed },
				["@lsp.type.enum.typescript"] = { fg = "#b8d7a3" },
				["@lsp.type.interface.typescript"] = { fg = "#b8d7a3" },
			},
		})
		vim.cmd.colorscheme("vscode")
	end,
}
