-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
if true then return {} end

return {
  "romgrk/barbar.nvim",
  lazy = false,
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    auto_hide = 1,
    sidebar_filetypes = {
      NvimTree = true,
      ["neo-tree"] = { event = "BufWipeout" },
    },
    icons = {
      -- separator = { left = "▎", right = "" },
      pinned = { button = "", filename = true },
    },
  },
  version = "^1.0.0", -- optional: only update when a new 1.x version is released
  keys = {
    { "H", "<cmd>BufferPrevious<cr>" },
    { "L", "<cmd>BufferNext<cr>" },
    { "<leader>bp", "<cmd>BufferPin<cr>" },
    { "<leader>bo", "<cmd>BufferCloseAllButCurrentOrPinned<cr>" },
    { "<leader>bs", "<cmd>BufferPick<cr>" },
    { "<leader>bx", "<cmd>BufferPickDelete<cr>" },
  },
}
