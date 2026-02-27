return {
  -- {
  --   'iamcco/markdown-preview.nvim',
  --   cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  --   build = function()
  --     require('lazy').load { plugins = { 'markdown-preview.nvim' } }
  --     vim.fn['mkdp#util#install']()
  --   end,
  --   keys = {
  --     {
  --       '<leader>cp',
  --       ft = 'markdown',
  --       '<cmd>MarkdownPreviewToggle<cr>',
  --       desc = 'Markdown Preview',
  --     },
  --   },
  --   config = function()
  --     vim.cmd [[do FileType]]
  --   end,
  -- },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      -- code = {
      --   sign = false,
      --   width = 'block',
      --   right_pad = 1,
      -- },
      heading = {
        enabled = false,
        sign = true,
        icons = { "󰼏 ", "󰎨 ", "󰼑 ", "󰎲 " },
        -- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        -- position = "inline",
        position = "overlay",
      },
      checkbox = {
        enabled = true,
      },
      bullet = {
        left_pad = 2,
      },
      pipe_table = {
        preset = "round",
        alignment_indicator = "",
      },
      code = {
        style = "full",
        width = "block",
        min_width = 80,
        left_pad = 2,
        language_pad = 2,
      },
    },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
  },
}
