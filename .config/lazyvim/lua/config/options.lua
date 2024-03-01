-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.cmd([[noremap Y Y]])

vim.opt.cmdheight = 2
vim.opt.tabstop = 4
vim.opt.laststatus = 3
vim.opt.cmdheight = 1
vim.opt.clipboard = ""

vim.g.lsp_disabled_servers = { "yaml" }
