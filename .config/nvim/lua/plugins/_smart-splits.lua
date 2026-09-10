vim.pack.add({
  "https://github.com/smart-splits-nvim/smart-splits.nvim",
})

require("smart-splits").setup({
  ignored_buftypes = {
    'nofile',
    'quickfix',
    'prompt',
  },
  at_edge = 'stop',
})

-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set('n', '<C-M-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<C-M-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<C-M-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<C-M-l>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
-- swapping buffers between windows
vim.keymap.set('n', '<C-M-H>', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<C-M-J>', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<C-M-K>', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<C-M-L>', require('smart-splits').swap_buf_right)
