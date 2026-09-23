vim.pack.add({
  "https://github.com/mason-org/mason.nvim.git",
})

require("mason").setup()

vim.keymap.set("n", "<leader>mm", "<cmd>Mason<CR>", { desc = "Open [m]ason [m]enu" })
