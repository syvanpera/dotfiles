return { -- Almost like magit
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    -- local neogit = require 'neogit'
    require("neogit").setup({})
    -- vim.keymap.set('n', '<leader>gs', neogit.open, { desc = '[G]it [S]tatus' })
  end,
  keys = {
    {
      "<leader>gg",
      function()
        require("neogit").open()
      end,
      desc = "Open Neogit",
    },
    {
      "<leader>gs",
      function()
        require("neogit").open()
      end,
      desc = "Open Neogit",
    },
  },
}
