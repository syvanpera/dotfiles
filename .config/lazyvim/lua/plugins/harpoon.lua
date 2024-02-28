return {
  "ThePrimeagen/harpoon",
  lazy = false,
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  conf = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        sync_on_ui_close = true,
      },
    })
  end,
  -- stylua: ignore
  keys = {
    { "<leader>h", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end },
    { "<leader>a", function() require("harpoon"):list():append() end },
    { "<leader>1", function() require("harpoon"):list():select(1) end },
    { "<leader>2", function() require("harpoon"):list():select(2) end },
    { "<leader>3", function() require("harpoon"):list():select(3) end },
    { "<leader>4", function() require("harpoon"):list():select(4) end },
    { "<leader>n", function() require("harpoon"):list():next() end },
    { "<leader>p", function() require("harpoon"):list():prev() end },
  },
}
