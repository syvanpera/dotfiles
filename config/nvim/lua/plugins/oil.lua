return {
  "stevearc/oil.nvim",
  dependencies = {
    { "echasnovski/mini.icons", opts = {} },
  },
  lazy = false,
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
    { "-", "<cmd>Oil<CR>", desc = "browse cwd", silent = true },
    { "<leader>-", "<cmd>Oil<CR>", desc = "browse cwd", silent = true },
    { "<leader>.", "<cmd>Oil<CR>", desc = "browse cwd", silent = true },
  },
}
