return {
  "folke/flash.nvim",
  config = function()
    local status_ok, flash = pcall(require, "flash")
    if not status_ok then
      return
    end

    local icons = require("lib.icons")

    flash.setup({
      prompt = {
        enabled = true,
        prefix = { { icons.ui.Separator .. icons.ui.Rocket .. icons.ui.ChevronRight .. " ", "FlashPromptIcon" } },
        win_config = { relative = "editor", width = 1, height = 1, row = 0, col = 0, zindex = 1000 },
      },
      modes = {
        char = {
          enabled = false,
        },
        search = {
          enabled = false,
        },
      },
    })
  end,
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  },
}
