return {
  "stevearc/oil.nvim",
  dependencies = {
    { "echasnovski/mini.icons", opts = {} },
  },
  lazy = false,
  opts = {},
  keys = {
    { "-", "<cmd>Oil<CR>", desc = "browse cwd", silent = true },
    { "<leader>-", "<cmd>Oil<CR>", desc = "browse cwd", silent = true },
    { "<leader>.", "<cmd>Oil<CR>", desc = "browse cwd", silent = true },
  },
}
