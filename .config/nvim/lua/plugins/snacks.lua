vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
  explorer = { enabled = true },
  picker = {
    sources = {
      explorer = {
        win = {
          list = {
            keys = {
              ["<Tab>"] = "confirm", -- open file / toggle folder
              [" "] = "select_and_next", -- toggle selection, move to next
            },
          },
        },
      },
    },
  },
})

vim.keymap.set("n", "<M-e>", function() Snacks.explorer() end, { desc = "File Explorer" })
vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "File Explorer" })

