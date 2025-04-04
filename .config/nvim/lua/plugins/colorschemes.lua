return {
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = true,
        overrides = function(_)
          return {
            LineNr = { bg = "none" },
            SignColumn = { bg = "none" },
            GitSignsAdd = { bg = "none" },
            GitSignsChange = { bg = "none" },
            GitSignsDelete = { bg = "none" },
            TelescopeBorder = { bg = "none" },
            NormalFloat = { bg = "none" },
            CursorLineSign = { link = "CursorLine" },
            CursorLineNr = { bg = "#363646" },
            FoldColumn = { bg = "none" },
            DiagnosticSignWarn = { bg = "none" },
            DiagnosticSignError = { bg = "none" },
            DiagnosticSignHint = { bg = "none" },
            DiagnosticSignOk = { bg = "none" },
            WinSeparator = { fg = "#34344d" },

            -- Markdown overrides
            ["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
            ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
            ["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
            ["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
            ["@markup.list.markdown"] = { link = "Function" }, -- + list
            ["@markup.quote.markdown"] = { link = "Error" }, -- > blockcode
            ["@markup.list.checked.markdown"] = { link = "WarningMsg" }, -- - [X] checked list item
            -- ["@markup.heading.1.markdown"] = { fg = "#ff0000" },
            ["@markup.heading.2.markdown"] = { fg = "#FFA066" },
            ["@markup.heading.3.markdown"] = { fg = "#87a987" },
            ["@markup.heading.4.markdown"] = { fg = "#8ba4b0" },
            ["@markup.heading.5.markdown"] = { fg = "#8992a7" },
          }
        end,
      })

      -- Load the colorscheme
      -- vim.cmd.colorscheme("kanagawa")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "auto", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true, -- disables setting the background color.
      })
      -- Load the colorscheme
      -- vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "cool",
        transparent = true,
        highlights = {
          -- ["CursorLine"] = { bg = "#546178" },
          ["CursorLineNr"] = { bg = "#546178" },
        },
      })
      -- Load the colorscheme
      -- vim.cmd.colorscheme("onedark")
    end,
  },
  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    priority = 1000,
    config = function()
      require("dracula").setup({
        transparent_bg = true,
      })
      -- Load the colorscheme
      -- vim.cmd.colorscheme("dracula")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      -- Load the colorscheme
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
