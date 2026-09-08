vim.pack.add({
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range("*") },
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
})

require("neo-tree").setup({
  filesystem = {
    follow_current_file = {
      enabled = true, -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    window = {
      mappings = {
        ['<tab>'] = 'open',
        ['o'] = 'open',
        ['\\'] = 'close_window',
      },
    },
  },
})

vim.keymap.set("n", "<M-e>", "<cmd>Neotree toggle reveal<CR>", { desc = "Toggle file explorer", silent = true })

