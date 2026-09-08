vim.pack.add({
    "https://github.com/nvim-mini/mini.nvim",
})

-- mini files ----
-- local MiniFiles = require("mini.files")
-- MiniFiles.setup({
--   mappings = {
--     go_in = "<CR>",
--     go_in_plus = "L",
--     go_out = "_",
--     go_out_plus = "H",
--   },
-- })
--
-- vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
-- vim.keymap.set("n", "<leader>-", function()
--   MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
--   MiniFiles.reveal_cwd()
-- end, { desc = "Toggle into currently opened file" })

--- mini icons ----
require('mini.icons').setup()
-- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
MiniIcons.mock_nvim_web_devicons()

--- mini ai ---
-- Better Around/Inside textobjects
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require("mini.ai").setup({
  -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
})

--- mini notify ---
require("mini.notify").setup({
  -- only show messages
  content = {
    format = function(notif)
      return notif.msg
    end,
  },
})

--- mini cmdline completion ---
-- require("mini.cmdline").setup({
--   autocorrect = {
--     enable = false
--   }
-- })

--- mini surround ---
-- Default Keymaps
-- | `sa` | Add surrounding or Direct with 'saiw' |
-- | `sd` | Delete surrounding |
-- | `sr` | Replace surrounding |
-- | `sf` | Find surrounding (right) |
-- | `sF` | Find surrounding (left) |
-- | `sh` | Highlight surrounding |
-- | `sn` | Update n_lines |
-- | `l` / `n` | as suffix for prev/next |
require("mini.surround").setup()

--- mini completions ---
local MiniCompletion = require("mini.completion")
MiniCompletion.setup({
  lsp_completion = {
    auto_setup = true,
  }
})

--- mini statusline ---
-- local statusline = require("mini.statusline")
-- -- Set `use_icons` to true if you have a Nerd Font
-- statusline.setup({ use_icons = true })
