-- return {
--   "ThePrimeagen/harpoon",
--   lazy = false,
--   branch = "harpoon2",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--   },
--   conf = function()
--     local harpoon = require("harpoon")
--     harpoon:setup({
--       settings = {
--         sync_on_ui_close = true,
--       },
--     })
--   end,
--   -- stylua: ignore
--   keys = {
--     { "<leader>hl", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Toggle Harpoon" },
--     { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Append to Harpoon" },
--     { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Select Harpoon 1" },
--     { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Select Harpoon 2"  },
--     { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Select Harpoon 3"  },
--     { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Select Harpoon 4"  },
--     { "<leader>hn", function() require("harpoon"):list():next() end, desc = "Next Harpoon" },
--     { "<leader>hp", function() require("harpoon"):list():prev() end, desc = "Previous Harpoon" },
--   },
-- }

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = function()
    local keys = {
      {
        "<leader>H",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon File",
      },
      {
        "<leader>h",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Quick Menu",
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        "<leader>" .. i,
        function()
          require("harpoon"):list():select(i)
        end,
        desc = "Harpoon to File " .. i,
      })
    end
    return keys
  end,
}
