vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "help", "oil" },
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
