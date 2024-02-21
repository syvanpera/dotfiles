local M = {}

M.treesitter = {
	ensure_installed = {
		"vim",
		"lua",
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"c",
		"markdown",
		"markdown_inline",
		"python",
		"go",
		"terraform",
		"hcl",
	},
	indent = {
		enable = true,
		-- disable = {
		--   "python"
		-- },
	},
}

M.mason = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"prettier",

		-- c/cpp stuff
		"clangd",
		"clang-format",

		-- python stuff
		"pyright",
		"mypy",
		"ruff",
		"debugpy",

		-- golang
		-- "gopls",
		-- "gofumpt",
		-- "goimports",
		-- "delve",

		-- terraform
		"terraform-ls",
		"tflint",
	},
}

-- git support in nvimtree
local actions = require("telescope.actions")
M.nvimtree = {
	auto_close = true,
	-- disable_netrw = false,
	-- hijack_netrw = false,

	git = {
		enable = true,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

M.telescope = {
	defaults = {
		mappings = {
			i = {
				["<C-l>"] = actions.cycle_history_next,
				["<C-h>"] = actions.cycle_history_prev,
				["<C-n>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<esc>"] = actions.close,
				["<C-g>"] = actions.close,
			},
		},
	},
}

return M
