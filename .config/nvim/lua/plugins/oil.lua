return {
  "stevearc/oil.nvim",
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require("oil")

    oil.setup({
      win_options = {
        relativenumber = false,
      },
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      float = {
        override = function(conf)
          local width = vim.api.nvim_get_option("columns")
          local height = vim.api.nvim_get_option("lines")
          local win_height = 15

          return vim.tbl_deep_extend("force", conf, {
            relative = "editor",
            width = width,
            height = win_height,
            row = height - win_height,
            col = 0,
          })
        end,
      },
      keymaps = {
        ["<esc>"] = "actions.close",
        ["q"] = "actions.close",
        ["H"] = "actions.toggle_hidden",
        ["s"] = "actions.select_split",
        ["v"] = "actions.select_vsplit",
        ["<C-c><C-c>"] = { mode = { "n", "i" }, callback = "<esc>ZZ" },
      },
    })
  end,
  keys = {
    -- {"<M-e>", function() require('oil').toggle_float() end },
    {
      "<leader>o",
      function()
        require("oil").open()
      end,
    },
    -- {"<leader>.", function() require('oil').open() end },
  },
}
