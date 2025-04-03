return {
  -- "github/copilot.vim"
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = {
      enabled = false,
      auto_trigger = false,
      keymap = {
        accept = "<C-f>",
      },
    },
  },
}
