---@type MappingsTable
local M = {}

M.disabled = {
	n = {
		["<C-n>"] = "",
		["<leader>b"] = "",
	},
}

M.general = {
	n = {
		["<M-s>"] = { "<cmd>w<cr>", "Save file" },

		-- code
		["<leader>cf"] = {
			function()
				require("conform").format()
			end,
			"formatting",
		},
	},
	v = {
		[">"] = { ">gv", "indent" },
	},
}

-- more keybinds!

M.nvimtree = {
	plugin = true,

	n = {
		["<M-e>"] = { "<cmd>NvimTreeToggle<cr>", "Toggle nvimtree" },
	},
}

M.tabufline = {
	plugin = true,

	n = {
		["H"] = {
			function()
				require("nvchad.tabufline").tabuflinePrev()
			end,
			"Goto prev buffer",
		},

		["L"] = {
			function()
				require("nvchad.tabufline").tabuflineNext()
			end,
			"Goto next buffer",
		},

		-- buffers
		["<leader>bd"] = {
			function()
				require("nvchad.tabufline").close_buffer()
			end,
			"Close buffer",
		},
		["<leader>bo"] = {
			function()
				require("nvchad.tabufline").closeOtherBufs()
			end,
			"Close other buffers",
		},
	},
}

M.gitsigns = {
	plugin = true,

	n = {
		-- git
		["<leader>gd"] = {
			function()
				require("gitsigns").toggle_deleted()
			end,
			"Toggle deleted",
		},
	},
}

M.telescope = {
	plugin = true,

	n = {
		-- buffers
		["<leader>bb"] = { "<cmd>Telescope buffers<CR>", "Find buffers" },
		["<leader>."] = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", "File browser" },
		["<leader>fp"] = {
			function()
				require("telescope.builtin").find_files({
					hidden = true,
					no_ignore = true,
					cwd = "/home/tuomo/.config/nvim/lua/custom",
				})
			end,
			"Find nvim config files",
		},
	},
}

M["nvim-tmux-navigation"] = {
	plugin = true,

	n = {
		["<C-h>"] = {
			function()
				require("nvim-tmux-navigation").NvimTmuxNavigateLeft()
			end,
		},
		["<C-l>"] = {
			function()
				require("nvim-tmux-navigation").NvimTmuxNavigateRight()
			end,
		},
		["<C-k>"] = {
			function()
				require("nvim-tmux-navigation").NvimTmuxNavigateUp()
			end,
		},
		["<C-j>"] = {
			function()
				require("nvim-tmux-navigation").NvimTmuxNavigateDown()
			end,
		},
	},
}

return M
