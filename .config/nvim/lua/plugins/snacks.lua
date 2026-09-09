vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
  bigfile = { enabled = true },
  indent = {
    enabled = true,
    animate = {
      enabled = false
    }
  },
  explorer = {
    enabled = true,
    replace_netrw = false,
  },
  picker = {
    sources = {
      explorer = {
        -- auto-unfold tree down to the selected file
        -- auto_close = false,
        -- jump = { close = false },
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

vim.keymap.set("n", "<M-e>", function() Snacks.explorer() end, { desc = "explorer" })
vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "explorer" })
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "lazygit" })
vim.keymap.set("n", "<leader>gl", function() Snacks.lazygit.log() end, { desc = "lazygit log" })
