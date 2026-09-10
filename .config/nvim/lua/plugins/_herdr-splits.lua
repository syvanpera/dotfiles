vim.pack.add({
  "https://github.com/lmilojevicc/herdr-splits.nvim",
})

require("herdr-splits").setup()

vim.keymap.set("n", "<C-h>", function() require('herdr-splits').move_cursor_left() end, { desc = 'Navigate left' })
vim.keymap.set("n", "<C-j>", function() require('herdr-splits').move_cursor_down() end, { desc = 'Navigate down' })
vim.keymap.set("n", "<C-k>", function() require('herdr-splits').move_cursor_up() end, { desc = 'Navigate up' })
vim.keymap.set("n", "<C-l>", function() require('herdr-splits').move_cursor_right() end, { desc = 'Navigate right' })
vim.keymap.set("n", "<C-M-h>", function() require('herdr-splits').resize_left() end, { desc = 'Resize left' })
vim.keymap.set("n", "<C-M-j>", function() require('herdr-splits').resize_down() end, { desc = 'Resize down' })
vim.keymap.set("n", "<C-M-k>", function() require('herdr-splits').resize_up() end, { desc = 'Resize up' })
vim.keymap.set("n", "<C-M-l>", function() require('herdr-splits').resize_right() end, { desc = 'Resize right' })
