return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "go",
      "python",
      "lua",
      "rust",
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["of"] = "@function.outer",
          ["if"] = "@function.inner",
          ["oc"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
      lsp_interop = {
        enable = true,
        border = 'single',
        floating_preview_opts = {},
        peek_definition_code = {
          ["<leader>lp"] = "@function.outer",
          ["<leader>lP"] = "@class.outer",
        },
      },
    },
  },
}
 
