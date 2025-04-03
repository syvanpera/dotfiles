return {
  "folke/trouble.nvim",
  -- dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  opts = {
    focus = true,
  },
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "buffer diagnostics (trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle<CR>", desc = "diagnostics (trouble)" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "location list (trouble)" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "quickfix list (trouble)" },
    { "<leader>cS", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "symbols (trouble)" },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
      desc = "LSP definitions / references / ... (trouble)",
    },
  },
}
