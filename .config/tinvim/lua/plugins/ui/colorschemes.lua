return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("tokyonight").setup({
        style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = true, -- Enable this to disable setting the background color
        on_highlights = function(hl, c)
          hl.WinSeparator = { fg = "#292e42" }
        end,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    enabled = false,
    config = function()
      local status_ok, kanagawa = pcall(require, "kanagawa")
      if not status_ok then
        return
      end

      kanagawa.setup({
        transparent = true,
        background = {
          dark = "wave",
        },
        overrides = function(colors)
          local theme = colors.theme

          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            -- Assign a static color to strings
            LineNr = { bg = "none" },
            SignColumn = { bg = "none" },
            CursorLineNr = { fg = "#ff9e3b", bg = "#363646" },

            CursorLineSign = { link = "CursorLine" },

            -- Block-like modern borderless Telescope UI
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

            -- More uniform colors for the popup menu
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            WinSeparator = { fg = "#748b84" },
          }
        end,
      })
      kanagawa.load()
    end,
    lazy = false,
    priority = 1000,
  },
  {
    "navarasu/onedark.nvim",
    enabled = false,
    config = function()
      require("onedark").setup({
        -- Main options --
        style = "cool", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = true, -- Show/hide background
      })
      require("onedark").load()
    end,
  },
  {
    "catppuccin/nvim",
    enabled = false,
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        styles = {
          conditionals = {},
        },
      })
      -- load the colorscheme here
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
