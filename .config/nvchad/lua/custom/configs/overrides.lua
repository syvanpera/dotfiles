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

		-- shell stuff
		"shfmt",

		-- golang
		"gopls",
		"gofumpt",
		"goimports",
		"delve",

		-- terraform
		"terraform-ls",
		"tflint",
	},
}

-- git support in nvimtree
M.nvimtree = {
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

local actions = require("telescope.actions")
M.telescope = {
	defaults = {
		mappings = {
			i = {
				["<C-g>"] = actions.close,
			},
		},
	},
}

return M
