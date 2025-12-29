local f = require("f")
local fn = f.fn
local set = vim.keymap.set

set("v", "<leader>y", '"+y', { desc = "yank to clipboard" })

set("n", "<C-s>", "<cmd>w<cr>", { desc = "save buffer" })
set("n", "<M-s>", "<cmd>w<cr>", { desc = "save buffer" })
set("n", "<leader><tab>", "<C-^>", { desc = "switch to other buffer" })

set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "lazy" })

set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
-- set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- set('n', '<leader>en', fn(vim.diagnostic.jump, { count = 1, float = true }), { desc = 'Go to [N]ext diagnostic message' })
-- set('n', '<leader>ep', fn(vim.diagnostic.jump, { count = -1, float = true }), { desc = 'Go to [P]rev diagnostic message' })

set("n", "<leader>en", fn(vim.diagnostic.jump, { count = 1, float = true }), { desc = "next diagnostic" })
set("n", "<leader>ep", fn(vim.diagnostic.jump, { count = -1, float = true }), { desc = "prev diagnostic" })
set("n", "<leader>el", vim.diagnostic.open_float, { desc = "line diagnostics" })
set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "line diagnostics" })
set("n", "gl", vim.diagnostic.open_float, { desc = "line diagnostics" })

set("n", "<leader>th", "<cmd>nohl<CR>", { desc = "clear highlights" })

-- These mappings control the size of splits (height/width)
set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-;>", "<C-W>+")
set("n", "<M-:>", "<C-W>-")
