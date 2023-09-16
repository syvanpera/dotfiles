return {
  n = {
    ["<leader>w"] = false,
    ["<leader>c"] = false,
    ["<leader>bl"] = false,

    ["<M-e>"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },
    ["<M-s>"] = { ":w<cr>", desc = "Save File" },
    ["<M-r>"] = { "<cmd>Telescope lsp_document_symbols<cr>", desc = "Symbols" },
    ["<M-F>"] = { "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    ["<M-f>"] = { "<cmd>lua require('spectre').open()<cr>", desc = "Spectre" },

    ["<leader><tab>"] = { "<cmd>e # <cr>", desc = "Alternate file" },

    ["<leader>bb"] = { "<cmd>Telescope buffers <cr>", desc = "Show buffers" },

    ["<leader>e"] = { false, desc = " Errors/diagnostics" },
    ["<leader>el"] = { "<cmd>TroubleToggle<cr>", desc = "List errors" },
    ["<leader>en"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next error" },
    ["<leader>ep"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev error" },

    ["<leader>fp"] = {
      function()
        require("telescope.builtin").find_files {
          hidden = true,
          no_ignore = true,
          cwd = "/home/tuomo/.config/nvim/lua/user",
        }
      end,
      desc = "Find nvim config files",
    },

    ["<leader>."] = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "File browser" },
  },
  v = {
    ["<leader>y"] = { '"*y', desc = "Copy to clipboard" },
    ["<M-c>"] = { '"*y', desc = "Copy to clipboard" },
  },
}
