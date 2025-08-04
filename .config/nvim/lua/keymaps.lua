vim.keymap.set(
	{ "n", "v" },
	"<Space>",
	"<Nop>",
	{ desc = "Disable spacebar key's default behaviour", noremap = true, silent = true }
)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<C-o>:w<CR>", { desc = "Save file in insert mode" })
vim.keymap.set("n", "<C-q>", ":q<CR>", { desc = "Quit" })
vim.keymap.set("i", "<C-q>", "<C-o>:q<CR>", { desc = "Quit in insert mode" })
vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear highlights" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete char without copying" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Down scroll and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Up scroll and center" })

vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "kj", "<Esc>", { desc = "Exit insert mode" })

vim.keymap.set({ "n", "i" }, "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set({ "n", "i" }, "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set({ "n", "i" }, "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set({ "n", "i" }, "<C-l>", require("smart-splits").move_cursor_right)

vim.keymap.set({ "n", "i" }, "<C-A-h>", require("smart-splits").resize_left, { desc = "Resize" })
vim.keymap.set({ "n", "i" }, "<C-A-j>", require("smart-splits").resize_down, { desc = "Resize" })
vim.keymap.set({ "n", "i" }, "<C-A-k>", require("smart-splits").resize_up, { desc = "Resize" })
vim.keymap.set({ "n", "i" }, "<C-A-l>", require("smart-splits").resize_right, { desc = "Resize" })

vim.keymap.set("n", "<leader>v", "<C-w>s", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>h", "<C-w>v", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>eq", "<C-w>=", { desc = "Make split windows equal size" })

vim.keymap.set("v", "<", "<gv", { desc = "Stay in indent mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Stay in indent mode" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

vim.keymap.set("n", "<leader>,", function()
	vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end, { desc = "Go to NVIM config" })

vim.keymap.set("n", "<CR>", "m`o<Esc>``", { silent = true, desc = "New line below, no move" })
vim.keymap.set("n", "<C-CR>", "m`O<Esc>``", { silent = true, desc = "New line above, no move" })

vim.keymap.set("n", "<C-w>", ":set wrap!<CR>", { desc = "Toggle wrap" })
vim.keymap.set({ "n", "v" }, "g<C-I>", "g<C-A>", { noremap = true })

vim.keymap.set({ "n", "v" }, "gy", '"+y', { noremap = true, desc = "Yank to system clipboard" })

vim.keymap.set({ "n", "v" }, "gp", '"+p', { noremap = true, desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "gP", '"+P', { noremap = true, desc = "Paste before from system clipboard" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
