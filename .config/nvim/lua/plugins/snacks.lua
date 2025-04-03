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
    indent = { enabled = true },
    input = {
      enabled = true,
      icon = " ",
      icon_hl = "SnacksInputIcon",
      icon_pos = "left",
      prompt_pos = "title",
      win = {
        style = {
          position = "float",
          relative = "cursor",
          row = 1,
          keys = {
            n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
            i_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "i", expr = true },
            i_Cy = { "<C-y>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
            i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
            i_Cp = { "<C-p>", { "hist_up" }, mode = { "i", "n" } },
            i_Cn = { "<C-n>", { "hist_down" }, mode = { "i", "n" } },
          },
        },
      },
      expand = true,
    },
    picker = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = false },
  },
  keys = {
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "delete",
    },
    {
      "<leader>nn",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "list",
    },
    {
      "<leader>nd",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "dismiss",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "lazygit",
    },
    {
      "<leader>gb",
      function()
        Snacks.gitbrowse()
      end,
      desc = "browse",
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "lazygit log current file",
    },
    {
      "<leader>gL",
      function()
        Snacks.lazygit.log()
      end,
      desc = "lazygit log (cwd)",
    },
  },
}
