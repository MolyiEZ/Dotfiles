vim.keymap.set(
	{ "n", "v" },
	"<Space>",
	"<Nop>",
	{ desc = "Disable spacebar key's default behaviour", noremap = true, silent = true }
)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "Save and quit" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<C-q>", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", ":q!<CR>", { desc = "Force quit" })
vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear highlights" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete char without copying" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Down scroll and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Up scroll and center" })

vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "kj", "<Esc>", { desc = "Exit insert mode" })

vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

vim.keymap.set("n", "<C-A-h>", require("smart-splits").resize_left, { desc = "Resize" })
vim.keymap.set("n", "<C-A-j>", require("smart-splits").resize_down, { desc = "Resize" })
vim.keymap.set("n", "<C-A-k>", require("smart-splits").resize_up, { desc = "Resize" })
vim.keymap.set("n", "<C-A-l>", require("smart-splits").resize_right, { desc = "Resize" })

vim.keymap.set("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>h", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>eq", "<C-w>=", { desc = "Make split windows equal size" })

vim.keymap.set("v", "<", "<gv", { desc = "Stay in indent mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Stay in indent mode" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })
