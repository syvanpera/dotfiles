-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Remove some default LazyVim keymaps -------------------

vim.keymap.del("n", "<leader><tab>l")
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>[")
vim.keymap.del("n", "<leader><tab>d")
vim.keymap.del("n", "<leader>bb")
-- vim.keymap.del("n", "<leader>e")

map("n", "<M-s>", "<cmd>w<cr>", { desc = "Save buffer" })
map("n", "<leader><tab>", "<C-^>", { desc = "Switch to other buffer" })
map("n", "<C-w>n", "<cmd>vnew<cr>", { desc = "New vertical split" })
map("n", "<C-w>N", "<cmd>new<cr>", { desc = "New horizontal split" })
map("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })

-- use jk to exit insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- toggles
map("n", "<leader>th", "<cmd>nohl<cr>", { desc = "toggle highlight" })

map("n", "-", "<cmd>Oil<cr>", { desc = "Edit current directory" })

-- map("n", "<leader>fp", Util.pick.config_files(), { desc = "Find Config File" })
