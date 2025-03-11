return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  dependencies = {
    "echasnovski/mini.icons",
    -- "folke/trouble.nvim",
  },
  config = function()
    local fzflua = require("fzf-lua")
    fzflua.setup({
      { "ivy" },
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        },
      },
    })
    fzflua.register_ui_select()

    -- local config = require("fzf-lua.config")
    -- local actions = require("trouble.sources.fzf").actions
    -- config.defaults.actions.files["ctrl-t"] = actions.open
  end,
  keys = {
    {
      "<leader>f'",
      function()
        require("fzf-lua").resume()
      end,
      desc = "resume find",
    },
    {
      "<leader>ff",
      function()
        require("fzf-lua").files()
      end,
      desc = "files",
    },
    {
      "<leader>fr",
      function()
        require("fzf-lua").oldfiles()
      end,
      desc = "recent files",
    },
    {
      "<leader>fc",
      function()
        require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "config",
    },
    {
      "<leader>bb",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "list",
    },
    {
      "<leader>fb",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "list",
    },
    {
      "<leader><leader>",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "find buffer",
    },
    {
      "<leader>fg",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "grep",
    },
    {
      "<leader>fh",
      function()
        require("fzf-lua").helptags()
      end,
      desc = "help",
    },
    {
      "<leader>fk",
      function()
        require("fzf-lua").keymaps()
      end,
      desc = "keymap",
    },
    {
      "<leader>fw",
      function()
        require("fzf-lua").grep_cword()
      end,
      desc = "word",
    },
    {
      "<leader>fW",
      function()
        require("fzf-lua").grep_cWORD()
      end,
      desc = "WORD",
    },
    {
      "<leader>f/",
      function()
        require("fzf-lua").lgrep_curbuf()
      end,
      desc = "grep current buffer",
    },
    -- { '<leader>bb', function() require('fzf-lua').buffers() end, desc = '[B][B]uffers' },
    {
      "<M-F>",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "live grep",
    },
  },
}
