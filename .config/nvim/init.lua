-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]

require("lazy").setup({
	require("plugins.multiple_cursors"),
	require("plugins.theme"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.lsp"),
	require("plugins.lazyDev"),
	require("plugins.telescope"),
	require("plugins.autocompletion"),
	require("plugins.autoformatter"),
	require("plugins.todo-comments"),
	require("plugins.smart-splits"),
})

-- [[ Requires ]]
require("keymaps")
require("options")


