return {
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

          -- Markdown overrides
          ["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
          ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
          ["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
          ["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
          ["@markup.list.markdown"] = { link = "Function" }, -- + list
          ["@markup.quote.markdown"] = { link = "Error" }, -- > blockcode
          ["@markup.list.checked.markdown"] = { link = "WarningMsg" }, -- - [X] checked list item
        }
      end,
    })

    -- Load the colorscheme
    vim.cmd.colorscheme("kanagawa")
  end,
}
