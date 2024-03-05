return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require("mini.ai").setup({ n_lines = 500 })

    require("mini.comment").setup()

    local hipatterns = require("mini.hipatterns")
    hipatterns.setup({
      highlighters = {
        -- -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        -- fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        -- hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
        -- todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
        -- note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })
  end,
}
