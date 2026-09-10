vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
  bigfile = { enabled = true },
  indent = {
    enabled = true,
    animate = {
      enabled = false
    }
  },
  explorer = {
    enabled = true,
    replace_netrw = false,
  },
  picker = {
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "i", "n" }},
        },
      },
    },
    sources = {
      explorer = {
        -- auto-unfold tree down to the selected file
        -- auto_close = false,
        -- jump = { close = false },
        win = {
          list = {
            keys = {
              ["<Tab>"] = "confirm", -- open file / toggle folder
              [" "] = "select_and_next", -- toggle selection, move to next
            },
          },
        },
      },
    },
  },
})

vim.keymap.set("n", "<M-e>", function() Snacks.explorer() end, { desc = "explorer" })
vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "explorer" })
vim.keymap.set("n", "<M-F>", function() Snacks.picker.grep({ hidden = true }) end, { desc = "Grep" })

-- git
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "lazygit" })
vim.keymap.set("n", "<leader>gl", function() Snacks.lazygit.log() end, { desc = "lazygit log" })

vim.keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "smart find files" })

-- buffers
vim.keymap.set("n", "<leader>bb", function() Snacks.picker.buffers() end, { desc = "buffers" })

-- find
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "buffers" })
vim.keymap.set("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "config files" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files({ hidden = true }) end, { desc = "files" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "git files" })
vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "projects" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "recent" })
vim.keymap.set("n", "<leader>ft", function() Snacks.picker.todo_comments() end, { desc = "todo" })

-- LSP
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "goto definition" })
vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "goto declaration" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "references" })
vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "goto implementation" })
vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "goto t[y]pe definition" })
vim.keymap.set("n", "gai", function() Snacks.picker.lsp_incoming_calls() end, { desc = "c[a]lls incoming" })
vim.keymap.set("n", "gao", function() Snacks.picker.lsp_outgoing_calls() end, { desc = "c[a]lls outgoing" })
vim.keymap.set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
vim.keymap.set("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP workspace symbols" })
