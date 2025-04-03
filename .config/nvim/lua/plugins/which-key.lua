return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "classic", -- or modern/helix
    -- delay = 300,
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>a", group = "ai" },
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>e", group = "error/diagnostic" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>n", group = "notification" },
        { "<leader>t", group = "toggle" },
        { "<leader>x", group = "diagnostic" },
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "buffer local keymaps (which-key)",
    },
  },
}
