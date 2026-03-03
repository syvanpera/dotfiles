return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
      require("gruvbox").setup({
          transparent_mode = true,
      })
  end,
  init = function()
      vim.cmd.colorscheme "gruvbox"
  end,
}

-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
--   init = function()
--     vim.cmd.colorscheme "tokyonight-night"
--   end,
-- }
