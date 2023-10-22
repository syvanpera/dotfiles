return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.colorscheme.nightfox-nvim", enabled = true },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        transparent = true,
      },
    },
  },
  -- { import = "astrocommunity.colorscheme.kanagawa-nvim", enabled = true },
  -- { import = "astrocommunity.colorscheme.catppuccin", enabled = true },
  -- {
  --   "catppuccin",
  --   opts = {
  --     flavour = "mocha",
  --     transparent_background = true,
  --     integrations = {
  --       sandwich = false,
  --       noice = true,
  --       mini = true,
  --       leap = true,
  --       markdown = true,
  --       neotest = true,
  --       cmp = true,
  --       overseer = true,
  --       lsp_trouble = true,
  --       rainbow_delimiters = true,
  --     },
  --   },
  -- },
}
