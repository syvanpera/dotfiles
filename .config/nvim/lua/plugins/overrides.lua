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

  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        animate = {
          enabled = false,
        },
      },
      scroll = {
        enabled = false,
      },
    },
  },

  -- {
  --   "folke/noice.nvim",
  --   enabled = false,
  --   opts = {
  --     lsp = {
  --       -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --       override = {
  --         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --         ["vim.lsp.util.stylize_markdown"] = true,
  --         ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
  --       },
  --     },
  --     -- you can enable a preset for easier configuration
  --     presets = {
  --       bottom_search = true, -- use a classic bottom cmdline for search
  --       command_palette = true, -- position the cmdline and popupmenu together
  --       long_message_to_split = true, -- long messages will be sent to a split
  --       inc_rename = false, -- enables an input dialog for inc-rename.nvim
  --       lsp_doc_border = true, -- add a border to hover docs and signature help
  --     },
  --     cmdline = {
  --       enabled = true,
  --       view = "cmdline",
  --     },
  --     popupmenu = {
  --       enabled = true,
  --       backend = "cmp",
  --     },
  --   },
  -- },
}
