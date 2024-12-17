return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },

  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          enabled = false,
        },
        search = {
          enabled = false,
        },
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      window = {
        mappings = {
          ["<tab>"] = "open",
          ["o"] = "open",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
        },
      },
      -- default_component_configs = {
      --   indent = {
      --     with_expanders = false, -- if nil and file nesting is enabled, will enable expanders
      --     expander_collapsed = "",
      --     expander_expanded = "",
      --     expander_highlight = "NeoTreeExpander",
      --   },
      -- },
      -- filesystem = {
      --   filtered_items = {
      --     visible = true,
      --     hide_dotfiles = false,
      --     hide_gitignored = false,
      --     hide_hidden = false,
      --   },
      -- },
    },
    keys = {
      {
        "<M-e>",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").root() })
        end,
      },
    },
  },

  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<M-F>", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>bb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    },
  },
}
