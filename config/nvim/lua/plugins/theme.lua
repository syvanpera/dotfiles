return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
    })
    vim.cmd.colorscheme "catppuccin"
  end,
}

-- return {
--   "ellisonleao/gruvbox.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--       require("gruvbox").setup({
--           transparent_mode = true,
--           overrides = {
--               WhichKeyNormal = { link = "CursorLine" }
--           },
--       })
--   end,
--   init = function()
--       vim.cmd.colorscheme "gruvbox"
--   end,
-- }

-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
--   init = function()
--     vim.cmd.colorscheme "tokyonight-night"
--   end,
-- }
