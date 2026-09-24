vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
})

-- Server binaries come from Nix; servers not on PATH are skipped
vim.lsp.enable({
  "lua_ls",
  "stylua",
  "qmlls",
  "ts_ls",
  "gopls",
  "jsonls",
  "yamlls",
  "tailwindcss",
  "biome",
})
