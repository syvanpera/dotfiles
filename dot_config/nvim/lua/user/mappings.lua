local utils = require "astronvim.utils"
local get_icon = utils.get_icon
local is_available = utils.is_available
local maps = require("astronvim.utils").empty_map_table()

local sections = {
  p = { desc = get_icon("Project", 1, true) .. "Project" },
  P = { desc = get_icon("Package", 1, true) .. "Packages" },
  e = { false, desc = " Errors/diagnostics" },
  gw = { false, desc = "󱘎 Git worktrees"}
}

-- Plugin Manager
maps.n["<leader>P"] = sections.P
maps.n["<leader>Pi"] = { function() require("lazy").install() end, desc = "Plugins Install" }
maps.n["<leader>Ps"] = { function() require("lazy").home() end, desc = "Plugins Status" }
maps.n["<leader>PS"] = { function() require("lazy").sync() end, desc = "Plugins Sync" }
maps.n["<leader>Pu"] = { function() require("lazy").check() end, desc = "Plugins Check Updates" }
maps.n["<leader>PU"] = { function() require("lazy").update() end, desc = "Plugins Update" }

-- AstroNvim
maps.n["<leader>Pa"] = { "<cmd>AstroUpdatePackages<cr>", desc = "Update Plugins and Mason Packages" }
maps.n["<leader>PA"] = { "<cmd>AstroUpdate<cr>", desc = "AstroNvim Update" }
maps.n["<leader>Pv"] = { "<cmd>AstroVersion<cr>", desc = "AstroNvim Version" }
maps.n["<leader>Pl"] = { "<cmd>AstroChangelog<cr>", desc = "AstroNvim Changelog" }

-- Package Manager
if is_available "mason.nvim" then
  maps.n["<leader>Pm"] = { "<cmd>Mason<cr>", desc = "Mason Installer" }
  maps.n["<leader>PM"] = { "<cmd>MasonUpdateAll<cr>", desc = "Mason Update" }
end

-- Projects
maps.n["<leader>p"] = sections.p
maps.n["<leader>pf"] = { "<cmd>Telescope find_files theme=ivy<cr>", desc = "Find files" }

maps.n["<leader>w"] = false
maps.n["<leader>c"] = false
maps.n["<leader>bl"] = false

maps.n["gD"] = { "<cmd>vsplit<CR>gd" }

maps.n["<M-e>"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree files" }
maps.n["<M-b>"] = { "<cmd>Neotree toggle source=buffers<cr>", desc = "Toggle Neotree buffers" }
maps.n["<M-s>"] = { ":w<cr>", desc = "Save File" }
maps.n["<M-r>"] = { "<cmd>Telescope lsp_document_symbols theme=ivy<cr>", desc = "Symbols" }
maps.n["<M-F>"] = { "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Live grep" }
maps.n["<M-f>"] = { "<cmd>lua require('spectre').open()<cr>", desc = "Spectre" }

maps.n["<leader><tab>"] = { "<cmd>e # <cr>", desc = "Alternate file" }

maps.n["<leader>ff"] = { "<cmd>Telescope find_files theme=ivy<cr>", desc = "Find files" }
maps.n["<leader>bb"] = { "<cmd>Telescope buffers theme=ivy<cr>", desc = "Find buffers" }

maps.n["<leader>e"] = sections.e
maps.n["<leader>el"] = { "<cmd>TroubleToggle<cr>", desc = "List errors" }
maps.n["<leader>en"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next error" }
maps.n["<leader>ep"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev error" }

maps.n["<leader>gw"] = sections.gw
maps.n["<leader>gwm"] = { "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", desc = "Manage worktrees"}
maps.n["<leader>gwc"] = { "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", desc = "Create worktree"}

maps.n["<leader>fp"] = {
  function()
    require("telescope.builtin").find_files {
      hidden = true,
      no_ignore = true,
      cwd = "/home/tuomo/.config/nvim/lua/user",
    }
  end,
  desc = "Find nvim config files",
}

maps.n["<leader>."] = { "<cmd>Telescope file_browser theme=ivy path=%:p:h select_buffer=true<cr>", desc = "File browser" }


-- Visual mode
maps.v["<leader>y"] = { '"+y', desc = "Copy to clipboard" }
maps.v["<M-c>"] = { '"+y', desc = "Copy to clipboard" }

return maps
