-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "help", "oil", "gitsigns-blame" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>bd<CR>", { silent = true, buffer = true })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "copilot-*",
  callback = function()
    -- Set buffer-local options
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.conceallevel = 0
  end,
})

-- Folding for Terraform files using Treesitter
vim.api.nvim_create_autocmd("FileType", {
  -- pattern = "terraform,terraform-vars",
  pattern = "terraform-vars",
  group = vim.api.nvim_create_augroup("TerraformFolding", { clear = true }),
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.treeistter.foldexpr()"
  end,
})
