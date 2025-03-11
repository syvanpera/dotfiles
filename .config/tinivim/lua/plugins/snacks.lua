return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    picker = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = false },
  },
  keys = {
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "delete" },
    { "<leader>nn", function() Snacks.notifier.show_history() end, desc = "list" },
    { "<leader>nd", function() Snacks.notifier.show_history() end, desc = "dismiss" },
    { "<leader>gg", function() Snacks.lazygit() end, desc = "lazygit" },
    { "<leader>gb", function() Snacks.gitbrowse() end, desc = "browse" },
    { "<leader>gl", function() Snacks.lazygit.log_file() end, desc = "lazygit log current file" },
    { "<leader>gL", function() Snacks.lazygit.log() end, desc = "lazygit log (cwd)" },
  },
}
