vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/catppuccin/nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/NMAC427/guess-indent.nvim",
  "https://github.com/folke/todo-comments.nvim",
})


--- catppuccin theme ---
require("catppuccin").setup({
  transparent_background = true,
  float = {
    transparent = true,
  },
})


--- tokyo night theme ---
require("tokyonight").setup({
  style = "night",
  transparent = true,
})


vim.cmd.colorscheme 'catppuccin'


--- oil.nvim ---
require("oil").setup({
  keymaps = {
    ["q"] = { "actions.close", mode = "n" },
  }
})

vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Browse cwd" })


--- guess indent ---
require("guess-indent").setup({})


--- todo comments ---
require("todo-comments").setup({ signs = true })


local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'plugins')
local modules = {}
for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
  if (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' and not file_name:match '^_' then
    table.insert(modules, (file_name:gsub('%.lua$', '')))
  end
end
table.sort(modules)
for _, module in ipairs(modules) do
  require('plugins.' .. module)
end
