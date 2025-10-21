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

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]

require("lazy").setup({
	require("plugins.conform"),
	require("plugins.blink"),
	require("plugins.lsp"),
	require("plugins.treesitter"),
	require("plugins.lualine"),
	require("plugins.matchup"),
	require("plugins.indent"),
	require("plugins.smart_splits"),
	require("plugins.surround"),
	require("plugins.telescope"),
	require("plugins.theme"),
	require("plugins.todo_comments"),
	require("plugins.tpipeline"),
	require("plugins.tabout"),
	require("plugins.yazi"),
	require("plugins.noice"),
	require("plugins.trouble"),
	require("plugins.project"),
	require("plugins.multiple_cursors"),
	require("plugins.luau_lsp"),
	require("plugins.autopair"),
	require("plugins.awatcher"),

	-- require("plugins.lazyDev"),
	-- require("plugins.flash"),
	-- require("plugins.codedocs"),
	-- require("plugins.rainbow_delimiters"),
	-- require("plugins.gitsigns"),
	-- require("plugins.which_key"),
	-- require("plugins.autotag"),
	-- require("plugins.fugitive"),
	-- require("plugins.undotree"),
	-- require("plugins.code_runner"),
	-- require("plugins.comment"),
	-- require("plugins.obsidian"),
})

-- [[ Requires ]]
require("keymaps")
require("options")
