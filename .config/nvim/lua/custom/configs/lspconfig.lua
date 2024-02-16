local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "pyright", "terraformls", "tflint" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- lspconfig.pyright.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = {"python"},
-- }

-- lspconfig.terraformls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = {"terraform"},
-- }

-- lspconfig.tflint.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = {"terraform"},
-- }

-- lspconfig.gopls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   cmd = {"gopls"},
--   filetypes = {"go", "gomod", "gowork", "gotmpl"},
--   root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
--   settings = {
--     gopls = {
--       completeUnimported = true,
--       usePlaceholders = true,
--       analyses = {
--         unusedparams = true,
--       },
--     },
--   },
-- }
