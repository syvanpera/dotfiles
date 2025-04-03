-- return {
--   "lewis6991/gitsigns.nvim",
--   opts = {
--     signs_staged_enable = true,
--     signcolumn = true,
--     numhl = true,
--     current_line_blame = true,
--     current_line_blame_opts = {
--       virt_text = true,
--       virt_text_pos = "right_align", -- or 'eol'
--       delay = 1000,
--       ignore_whitespace = false,
--       virt_text_priority = 100,
--       use_focus = true,
--     },
--   },
-- }

return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      -- add = { text = ' ' },
      -- change = { text = ' ' },
      -- delete = { text = ' ' },
      -- topdelete = { text = ' ' },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signs_staged = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      -- add = { text = ' ' },
      -- change = { text = ' ' },
      -- delete = { text = ' ' },
      -- topdelete = { text = ' ' },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signs_staged_enable = true,
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
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
