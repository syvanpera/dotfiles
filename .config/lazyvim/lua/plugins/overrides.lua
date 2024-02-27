return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  {
    "folke/noice.nvim",
    -- enabled = false,
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline",
      },
      popupmenu = {
        enabled = true,
      },
      presets = {
        command_palette = false,
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
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
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },

  {
    "echasnovski/mini.pairs",
    enabled = false,
  },

  {
    "echasnovski/mini.indentscope",
    enabled = false,
    opts = {
      draw = {
        animation = require("mini.indentscope").gen_animation.none(),
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      window = {
        mappings = {
          ["<tab>"] = "open",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
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
    "nvim-telescope/telescope.nvim",
    opts = {
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
    },
  },

  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          enabled = false,
        },
      },
    },
  },

  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>el", "<cmd>TroubleToggle<cr>" },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local Util = require("lazyvim.util")
      local lazy_status = require("lazy.status")
      local icons = require("lazyvim.config").icons

      require("lualine").setup({
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
          component_separators = "|",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            { "mode", separator = { left = "" }, right_padding = 2 },
          },
          lualine_c = {},
          lualine_b = {
            Util.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { Util.lualine.pretty_path() },
            { "branch", icon = "" },
          },
          lualine_x = { { lazy_status.updates, cond = lazy_status.has_updates }, "fileformat" },
          lualine_y = { "filetype", "progress" },
          lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        tabline = {},
        extensions = {},
      })
    end,
  },
}
