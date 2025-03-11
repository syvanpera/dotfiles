return {
  "stevearc/oil.nvim",
  dependencies = {
    { "echasnovski/mini.icons", opts = {} }
  },
  lazy = false,
  opts = {},
  keys = {
    { '<leader>-', '<cmd>Oil --float<CR>', desc = 'browse cwd', silent = true },
    { '<leader>.', '<cmd>Oil --float<CR>', desc = 'browse cwd', silent = true },
  },
}
