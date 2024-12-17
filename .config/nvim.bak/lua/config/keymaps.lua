local Util = require("lazyvim.util")

local map = vim.keymap.set

-- General Keymaps -------------------

vim.keymap.del("n", "<leader><tab>l")
vim.keymap.del("n", "<leader><tab>f")
vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<leader><tab>]")
vim.keymap.del("n", "<leader><tab>[")
vim.keymap.del("n", "<leader><tab>d")
vim.keymap.del("n", "<leader>e")

-- map("n", "<leader><tab>", "")

map("n", "<M-s>", "<cmd>w<cr>", { desc = "Save buffer" })
map("n", "<leader><tab>", "<C-^>", { desc = "Switch to other buffer" })
map("n", "<C-w>n", "<cmd>vnew<cr>", { desc = "New vertical split" })
map("n", "<C-w>N", "<cmd>new<cr>", { desc = "New horizontal split" })
map("n", "<M-r>", "<cmd>AerialToggle<cr>", { desc = "Toggle Aerial (symbols)" })
map("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })

-- use jk to exit insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- workspace (tab) operations
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader>te", "<cmd>tabedit %<cr>", { desc = "Open buffer in new tab" })
map("n", "<leader>tl", "<cmd>tabs<cr>", { desc = "List tabs" })
map("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close other tabs" })
map("n", "<leader>tj", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader>tk", "<cmd>tabprev<cr>", { desc = "Prev tab" })

-- buffer operations
map("n", "tk", ":blast<cr>", { desc = "Move buffer to top" })
map("n", "tj", ":bfirst<cr>", { desc = "Move buffer to bottom" })
map("n", "th", ":bprev<cr>", { desc = "Previous buffer" })
map("n", "tl", ":bnext<cr>", { desc = "Next buffer" })
-- map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- toggles
map("n", "<leader>th", "<cmd>nohl<cr>", { desc = "[T]oggle [H]ighliht" })

-- copilot
-- map("i", "<C-f>", function()
--   vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
-- end, { desc = "Copilot Accept", replace_keycodes = true, nowait = true, silent = true, expr = true, noremap = true })
-- map("i", "<C-f>", "copilot#Accept()", { silent = true, expr = true, desc = "Copilot Accept" })

map("n", "<leader>fp", Util.pick.config_files(), { desc = "Find Config File" })

-- map("n", "<M-e>", function()
--   require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
-- end, { remap = true, silent = true, desc = "Toggle NeoTree" })
-- map("n", "<M-E>", function()
--   require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
-- end, { remap = true, silent = true, desc = "Toggle NeoTree" })
-- map("n", "<M-s>", "<cmd>w<cr>", { noremap = true, silent = true, desc = "Save buffer" })
-- map("n", "<M-F>", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true, desc = "Live grep" })
-- map("n", "<M-r>", function()
--   require("telescope.builtin").lsp_document_symbols({
--     symbols = require("lazyvim.config").get_kind_filter(),
--   })
-- end, { noremap = true, silent = true, desc = "Goto Symbol" })
--
-- map("n", "<leader>sx", require("telescope.builtin").resume, { noremap = true, silent = true, desc = "Resume" })
-- map("n", "<leader>bb", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true, desc = "Buffers" })
-- map(
--   "n",
--   "<leader>.",
--   "<cmd>Telescope file_browser path=%:p:h=%:p:h<cr>",
--   { noremap = true, silent = true, desc = "Browse files" }
-- )
--
-- map("n", "<leader>fp", Util.telescope.config_files(), { noremap = true, silent = true, desc = "Find Config File" })

-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Show definition" })
-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })
-- vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })

-- increment/decrement numbers
-- keymap.set('n', '<leader>+', '<C-a>', { desc = 'Increment number' }) -- increment
-- keymap.set('n', '<leader>-', '<C-x>', { desc = 'Decrement number' }) -- decrement

-- window management
-- keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' }) -- split window vertically
-- keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' }) -- split window horizontally
-- keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' }) -- make split windows equal width & height
-- keymap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split' }) -- close current split window
--
-- keymap.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = 'Open new tab' }) -- open new tab
-- keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close current tab' }) -- close current tab
-- keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Go to next tab' }) --  go to next tab
-- keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = 'Go to previous tab' }) --  go to previous tab
-- keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = 'Open current buffer in new tab' }) --  move current buffer to new tab
