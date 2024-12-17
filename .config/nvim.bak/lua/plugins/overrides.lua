local Util = require("lazyvim.util")

return {
  {
    "folke/noice.nvim",
    enabled = false,
    -- opts = {
    --   cmdline = {
    --     enabled = true,
    --     view = "cmdline",
    --   },
    --   popupmenu = {
    --     enabled = true,
    --   },
    --   presets = {
    --     command_palette = false,
    --   },
    -- },
  },

  {
    "akinsho/bufferline.nvim",
    enabled = false,
    opts = {
      options = {
        mode = "tabs",
        -- always_show_bufferline = true,
        -- separator_style = "slant",
        -- indicator = {
        --   style = "underline",
        -- },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },

  {
    "echasnovski/mini.pairs",
    enabled = false,
  },

  --  {
  --    "echasnovski/mini.indentscope",
  --    enabled = false,
  --    opts = {
  --      draw = {
  --        animation = require("mini.indentscope").gen_animation.none(),
  --      },
  --    },
  --  },

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
      default_component_configs = {
        indent = {
          with_expanders = false, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
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
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader><tab>", desc = "Alternate file" },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        find_files = {
          theme = "ivy",
        },
        live_grep = {
          theme = "ivy",
        },
        buffers = {
          theme = "ivy",
        },
      },
      defaults = {
        mappings = {
          i = {
            ["<C-l>"] = require("telescope.actions").cycle_history_next,
            ["<C-h>"] = require("telescope.actions").cycle_history_prev,
            ["<C-n>"] = require("telescope.actions").move_selection_next,
            ["<C-p>"] = require("telescope.actions").move_selection_previous,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<esc>"] = require("telescope.actions").close,
            ["<C-g>"] = require("telescope.actions").close,
          },
        },
      },
    },
    keys = {
      {
        "<leader>.",
        "<cmd>Telescope file_browser path=%:p:h=%:p:h<cr>",
      },
      {
        "<M-F>",
        "<cmd>Telescope live_grep<cr>",
      },
      {
        "<leader>bb",
        "<cmd>Telescope buffers<CR>",
      },
      { "<leader>fF", Util.pick("files"), desc = "Find Files (cwd)" },
      { "<leader>ff", Util.pick("files", { cwd = nil }), desc = "Find Files (root)" },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-a>",
          node_incremental = "<C-a>",
          scope_incremental = false,
          node_decremental = "<C-s>",
        },
      },
    },
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
    "folke/trouble.nvim",
    keys = {
      { "<leader>el", "<cmd>TroubleToggle<cr>" },
      {
        "<leader>en",
        function()
          vim.diagnostic.goto_next({ float = { border = "rounded" } })
        end,
      },
      {
        "<leader>ep",
        function()
          vim.diagnostic.goto_prev({ float = { border = "rounded" } })
        end,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = "│",
        section_separators = { left = "", right = "" },
      },
    },
  },

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --     "ofseed/copilot-status.nvim", -- for github/copilot.vim
  --     -- "AndreM222/copilot-lualine", -- for zbirenbaum/copilot.lua
  --   },
  --   config = function()
  --     local Util = require("lazyvim.util")
  --     local lazy_status = require("lazy.status")
  --     local icons = require("lazyvim.config").icons
  --
  --     local lsp = {
  --       function()
  --         local msg = "No LSP"
  --         local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  --         local clients = vim.lsp.get_clients()
  --         if next(clients) == nil then
  --           return msg
  --         end
  --         for _, client in ipairs(clients) do
  --           local filetypes = client.config.filetypes
  --           if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
  --             return client.name
  --           end
  --         end
  --         return msg
  --       end,
  --       icon = " ",
  --       -- color = { fg = colors.fg, gui = "bold" },
  --     }
  --
  --     require("lualine").setup({
  --       options = {
  --         theme = "auto",
  --         globalstatus = true,
  --         disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
  --         component_separators = "|",
  --         section_separators = { left = "", right = "" },
  --       },
  --       sections = {
  --         lualine_a = {
  --           { "mode", separator = { left = "" }, right_padding = 2 },
  --         },
  --         lualine_c = {},
  --         lualine_b = {
  --           Util.lualine.root_dir(),
  --           { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
  --           { Util.lualine.pretty_path() },
  --         },
  --         lualine_x = {
  --           {
  --             "copilot",
  --             show_running = true,
  --             symbols = {
  --               status = {
  --                 enabled = " ",
  --                 disabled = " ",
  --               },
  --               spinners = require("copilot-status.spinners").dots_negative,
  --             },
  --           },
  --           { lazy_status.updates, cond = lazy_status.has_updates },
  --           "fileformat",
  --         },
  --         lualine_y = {
  --           { "branch", icon = "" },
  --           {
  --             "diagnostics",
  --             symbols = {
  --               error = icons.diagnostics.Error,
  --               warn = icons.diagnostics.Warn,
  --               info = icons.diagnostics.Info,
  --               hint = icons.diagnostics.Hint,
  --             },
  --           },
  --           lsp,
  --           "filetype",
  --           -- "o:encoding",
  --           -- "progress",
  --         },
  --         lualine_z = {
  --           { "location", separator = { right = "" }, left_padding = 2 },
  --         },
  --       },
  --       inactive_sections = {
  --         lualine_a = { "filename" },
  --         lualine_b = {},
  --         lualine_c = {},
  --         lualine_x = {},
  --         lualine_y = {},
  --         lualine_z = { "location" },
  --       },
  --       tabline = {},
  --       extensions = {},
  --     })
  --   end,
  -- },

  {
    "nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      cmp.setup.filetype({ "sql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        },
      })

      opts.mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        -- ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-f>"] = cmp.mapping.confirm({ select = false }),
        ["<C-y>"] = cmp.mapping.confirm({ select = false }),
        -- ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-g>"] = cmp.mapping.abort(),
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      mappings = {
        reset = {
          normal = "<C-r>",
          insert = "<C-r>",
        },
      },
    },
  },
}
