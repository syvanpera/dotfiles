-- Enable faster startup by caching compiled lua modules
vim.loader.enable()

-- core
require('core.options')
require('core.keymaps')
require('core.autocmd')
require('core.commands')
require('core.lsp')

-- plugins
require("plugins")
