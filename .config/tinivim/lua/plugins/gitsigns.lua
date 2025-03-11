return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs_staged_enable = true,
    signcolumn = true,
    numhl = true,
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "right_align", -- or 'eol'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
      use_focus = true,
    },
  },
}
