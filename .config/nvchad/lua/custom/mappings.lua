---@type MappingsTable
local M = {}

M.disabled = {
	n = {
		["<leader>b"] = "",
	},
}

M.general = {
	n = {
		-- buffers
		["<leader>bb"] = { "<cmd>Telescope buffers<CR>", "Find buffers" },
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

		-- files
		["<leader>."] = { "<cmd>Telescope file_browser theme=ivy path=%:p:h select_buffer=true<CR>", "File browser" },
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

		-- misc
		["<leader><tab>"] = { "<cmd>e #<CR>", "Alternate file" },
		["<M-s>"] = { "<cmd>w<CR>", "Save file" },
		["<M-e>"] = { "<cmd>NvimTreeToggle<CR>", "Toggle NvimTree" },
		["<M-F>"] = { "<cmd>Telescope live_grep<CR>", "Live grep" },

		--  format with conform
		["<leader>fm"] = {
			function()
				require("conform").format()
			end,
			"formatting",
		},
	},
	v = {
		[">"] = { ">gv", "indent" },
		["<leader>y"] = { '"+y', "Copy to clipboard" },
	},
}

M.dap = {
	plugin = true,
	n = {
		["<leader>db"] = { "<cmd>DapToggleBreakpoint<CR>", "Add breakpoint at line" },
		["<leader>dus"] = {
			function()
				local widgets = require("dap.ui.widgets")
				local sidebar = widgets.sidebar(widgets.scopes)
				sidebar.open()
			end,
			"Open debugging sidebar",
		},
	},
}

M.dap_python = {
	plugin = true,
	n = {
		["<leader>dpr"] = {
			function()
				require("dap-python").test_method()
			end,
			"Debug python test",
		},
	},
}

-- M.dap_go = {
--   plugin = true,
--   n = {
--     ["<leader>dgt"] = {
--       function()
--         require('dap-go').debug_test()
--       end,
--       "Debug go test"
--     },
--     ["<leader>dgl"] = {
--       function()
--         require('dap-go').debug_last()
--       end,
--       "Debug last go test"
--     }
--   }
-- }

M.tmux_navigation = {
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
