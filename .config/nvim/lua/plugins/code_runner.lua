return {
	"CRAG666/code_runner.nvim",
	opts = {
		filetype = {
			python = "python3 -u",
			typescript = "tsx",
			rust = {
				"cd $dir &&",
				"rustc $fileName &&",
				"$dir/$fileNameWithoutExt",
			},
		},
	},
	config = true,
}
