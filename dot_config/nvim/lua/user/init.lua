vim.cmd [[noremap Y Y]]

-- Enable gruvbox telescope theme
vim.g.gruvbox_baby_telescope_theme = 1
-- Enable gruvbox transparent mode
vim.g.gruvbox_baby_transparent_mode = 1

return {
  -- colorscheme = "catppuccin-mocha",
  colorscheme = "gruvbox-baby",
  -- colorscheme = "nightfox",

  lsp = {
    formatting = {
      format_on_save = true,
    },
  },
}
