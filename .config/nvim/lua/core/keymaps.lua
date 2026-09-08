-- Why they changed the default is beyond me
vim.cmd([[ noremap Y Y]])

local map = vim.keymap.set

-- replaces selected text WITHOUT losing what you yanked
map("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })

-- delete text without saving it to any register
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

map("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })

map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save buffer" })
map("n", "<M-s>", "<cmd>w<cr>", { desc = "Save buffer" })
map("n", "<leader><tab>", "<C-^>", { desc = "Switch to other buffer" })

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves lines down in visual selection" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves lines up in visual selection" })

map("v", "<", "<gv", { desc = "Unindent and keep selection" })
map("v", ">", ">gv", { desc = "Indent and keep selection" })

-- map("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

map("n", "<C-d>", "<C-d>zz", { desc = "Move down in buffer with cursor centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Move up in buffer with cursor centered" })

map("n", "n", "nzzzv", { desc = "Next search result with cursor centered" })
map("n", "N", "Nzzzv", { desc = "Prev search result with cursor centered" })

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })

map("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Makes file executable" })
map("n", "<leader>re", "<cmd>restart<cr>", { desc = "Restart config :restart)" })

-- native undotree
map("n", "<leader>u", function()
  vim.cmd.packadd("nvim.undotree")
  require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })
