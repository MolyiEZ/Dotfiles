return {
	"chomosuke/typst-preview.nvim",
	lazy = false, -- or ft = 'typst'
	version = "1.*",
	opts = {
		follow_cursor = true,
	}, -- lazy.nvim will implicitly calls `setup {}`
}
