return {
  n = {
    ["<leader>w"] = false,
    ["<leader>c"] = false,
    ["<leader>bl"] = false,

    ["gD"] = { "<cmd>vsplit<CR>gd" },

    ["<M-e>"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree files" },
    ["<M-b>"] = { "<cmd>Neotree toggle source=buffers<cr>", desc = "Toggle Neotree buffers" },
    ["<M-s>"] = { ":w<cr>", desc = "Save File" },
    ["<M-r>"] = { "<cmd>Telescope lsp_document_symbols theme=ivy<cr>", desc = "Symbols" },
    ["<M-F>"] = { "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Live grep" },
    ["<M-f>"] = { "<cmd>lua require('spectre').open()<cr>", desc = "Spectre" },

    ["<leader><tab>"] = { "<cmd>e # <cr>", desc = "Alternate file" },

    ["<leader>ff"] = { "<cmd>Telescope find_files theme=ivy<cr>", desc = "Find files" },
    ["<leader>bb"] = { "<cmd>Telescope buffers theme=ivy<cr>", desc = "Find buffers" },

    ["<leader>e"] = { false, desc = " Errors/diagnostics" },
    ["<leader>el"] = { "<cmd>TroubleToggle<cr>", desc = "List errors" },
    ["<leader>en"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next error" },
    ["<leader>ep"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev error" },

    ["<leader>gw"] = { false, desc = "󱘎 Worktrees"},
    ["<leader>gwm"] = { "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", desc = "Manage worktrees"},
    ["<leader>gwc"] = { "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", desc = "Create worktree"},

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

    ["<leader>."] = { "<cmd>Telescope file_browser theme=ivy path=%:p:h select_buffer=true<cr>", desc = "File browser" },
  },
  v = {
    ["<leader>y"] = { '"+y', desc = "Copy to clipboard" },
    ["<M-c>"] = { '"+y', desc = "Copy to clipboard" },
  },
}
