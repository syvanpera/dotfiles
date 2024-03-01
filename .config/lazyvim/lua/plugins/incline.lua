-- stylua: ignore
-- if true then return {} end

return {
  "b0o/incline.nvim",
  event = "VeryLazy",
  config = function()
    local helpers = require("incline.helpers")
    require("incline").setup({
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      render = function(props)
        local guibg = "#44406e"

        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local ft_icon, ft_bgcolor = require("nvim-web-devicons").get_icon_color(filename)
        local ft_fgcolor = ft_bgcolor and helpers.contrast_color(ft_bgcolor)
        local modified = vim.bo[props.buf].modified

        if props.focused == true then
          guibg = "#44406e"

          local buffer = {
            ft_icon and { "", guibg = "#181826", guifg = ft_bgcolor },
            ft_icon and { ft_icon, " ", guibg = ft_bgcolor, guifg = ft_fgcolor } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            ft_icon and { " ", guifg = guibg },
            guibg = guibg,
          }
          return buffer
        else
          guibg = "none"
          local tmp = ft_bgcolor
          ft_bgcolor = ft_fgcolor
          ft_fgcolor = tmp

          local buffer = {
            ft_icon and { "", guibg = "none", guifg = "#44406e" },
            ft_icon and { ft_icon, " ", guibg = "#44406e", guifg = ft_fgcolor } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            ft_icon and { " ", guifg = guibg },
            guibg = guibg,
          }

          return buffer
        end
      end,
    })
  end,
}
