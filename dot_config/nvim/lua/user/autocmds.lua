vim.api.nvim_create_autocmd(
  { "BufWritePost" },
  { pattern = { "~/.dotfiles/*" }, command = "!chezmoi apply --source-path '%'" }
)
vim.api.nvim_create_autocmd(
  { "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" },
  { pattern = { "*" }, command = "if mode() != 'c' | checktime | endif" }
)
