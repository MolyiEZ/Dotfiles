return {
	"vimpostor/vim-tpipeline",
	init = function()
		vim.defer_fn(function()
			vim.call("tpipeline#build_hooks")
		end, 0)
	end,
}
