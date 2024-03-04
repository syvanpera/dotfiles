local function load_config(package)
	return function()
		require("plugins." .. package)
	end
end

local plugins = {
	-- LazyVim for some nice utils and presets
	{
		"LazyVim/LazyVim",
	},
	-- UI
	{
		"rebelot/kanagawa.nvim",
		enabled = false,
		config = load_config("ui.kanagawa"),
		lazy = false,
		priority = 1000,
	},
	{
		"navarasu/onedark.nvim",
		enabled = false,
		config = function()
			require("onedark").setup({
				-- Main options --
				style = "cool", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
				transparent = true, -- Show/hide background
			})
			require("onedark").load()
		end,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				styles = {
					conditionals = {},
				},
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"ofseed/copilot-status.nvim", -- for github/copilot.vim
		},
		config = load_config("ui.lualine"),
		event = { "BufReadPre", "BufNewFile" },
	},
	-- Tools
	{
		"tpope/vim-sleuth",
	},
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-symbols.nvim",
			{ "ThePrimeagen/harpoon", branch = "harpoon2" },
			"MunifTanjim/nui.nvim",
		},
		config = load_config("tools.telescope"),
		cmd = "Telescope",
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = load_config("tools.nvim-tree"),
		cmd = "NvimTreeToggle",
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"windwp/nvim-spectre",
		config = load_config("tools.spectre"),
		cmd = "Spectre",
	},
	{
		"folke/flash.nvim",
		config = load_config("tools.flash"),
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"folke/which-key.nvim",
		config = load_config("tools.which-key"),
		event = "VeryLazy",
	},
	-- Git
	{
		"lewis6991/gitsigns.nvim",
		config = load_config("tools.gitsigns"),
		cmd = "Gitsigns",
		event = { "BufReadPre", "BufNewFile" },
	},
	{ -- Almost like magit
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			-- local neogit = require 'neogit'
			require("neogit").setup({})
			-- vim.keymap.set('n', '<leader>gs', neogit.open, { desc = '[G]it [S]tatus' })
		end,
		keys = {
			{
				"<leader>gg",
				function()
					require("neogit").open()
				end,
			},
			{
				"<leader>gs",
				function()
					require("neogit").open()
				end,
			},
		},
	},

	-- {
	-- 	"tpope/vim-fugitive",
	-- 	cmd = "Git",
	-- },

	-- Other
	{
		"2kabhishek/nerdy.nvim",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-telescope/telescope.nvim",
		},
		cmd = "Nerdy",
	},
	{
		"alexghergh/nvim-tmux-navigation",
		opts = {
			disable_when_zoomed = true,
		},
		keys = function()
			local nvim_tmux_nav = require("nvim-tmux-navigation")
			return {
				{ "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft },
				{ "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown },
				{ "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp },
				{ "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight },
			}
		end,
	},
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			require("mini.comment").setup()

			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					-- -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					-- fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
					-- hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
					-- todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
					-- note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},
	{
		-- Treesitter is a new parser generator tool that we can
		-- use in Neovim to power faster and more accurate
		-- syntax highlighting.
		{
			"nvim-treesitter/nvim-treesitter",
			version = false,
			build = ":TSUpdate",
			event = { "BufReadPre", "BufNewFile" },
			config = load_config("lang.treesitter"),
		},
	},
	-- Code
	{ -- Show me what I did wrong
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself
					-- many times.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-T>.
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("gD", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					-- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

					-- Fuzzy find all the symbols in your current workspace
					--  Similar to document symbols, except searches over your whole project.
					-- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

					-- Rename the variable under your cursor
					--  Most Language Servers support renaming across files, etc.
					-- map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					-- map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

					-- Opens a popup that displays documentation about the word under your cursor
					--  See `:help K` for why this keymap
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header
					-- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP Specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`tsserver`) will work just fine
				-- tsserver = {},
				--

				lua_ls = {
					-- cmd = {...},
					-- filetypes { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								-- Tells lua_ls where to find all the Lua files that you have loaded
								-- for your neovim configuration.
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
								-- If lua_ls is really slow on your computer, you can try this instead:
								-- library = { vim.env.VIMRUNTIME },
							},
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			-- Ensure the servers and tools above are installed
			--  To check the current status of installed tools and/or manually install
			--  other tools, you can run
			--    :Mason
			--
			--  You can press `g?` for help in this menu
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{ -- Autoformat
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				-- javascript = { { "prettierd", "prettier" } },
			},
		},
	},

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets
					-- This step is not supported in many windows environments
					-- Remove the below condition to re-enable on windows
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",

			-- If you want to add a bunch of pre-configured snippets,
			--    you can use this plugin to help you. It even has snippets
			--    for various frameworks/libraries/etc. but you will have to
			--    set up the ones that are useful for you.
			-- 'rafamadriz/friendly-snippets',
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					["<C-n>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-f>"] = cmp.mapping.confirm({ select = true }),

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},

	-- {
	--     'VonHeikemen/lsp-zero.nvim',
	--     branch = 'v3.x',
	--     dependencies = {
	--         'neovim/nvim-lspconfig',
	--         'williamboman/mason-lspconfig.nvim',
	--     },
	--     config = load_config('lang.lsp-zero'),
	--     event = { 'BufReadPre', 'BufNewFile' },
	-- },
	-- {
	--     'williamboman/mason.nvim',
	--     config = load_config('lang.mason'),
	--     cmd = 'Mason',
	-- },
	-- {
	--     'folke/neodev.nvim',
	--     ft = { 'lua', 'vim' },
	--     config = load_config('lang.neodev'),
	-- },
	-- {
	--     'neovim/nvim-lspconfig',
	--     cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
	--     event = { 'BufReadPre', 'BufNewFile' },
	--     dependencies = {
	--         { 'hrsh7th/cmp-nvim-lsp' },
	--         { 'williamboman/mason-lspconfig.nvim' },
	--     },
	--     config = function()
	--         -- This is where all the LSP shenanigans will live
	--         local lsp_zero = require('lsp-zero')
	--         lsp_zero.extend_lspconfig()
	--
	--         --- if you want to know more about lsp-zero and mason.nvim
	--         --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
	--         lsp_zero.on_attach(function(client, bufnr)
	--             -- see :help lsp-zero-keybindings
	--             -- to learn the available actions
	--             lsp_zero.default_keymaps({ buffer = bufnr })
	--         end)
	--
	--         require('mason-lspconfig').setup({
	--             ensure_installed = {},
	--             handlers = {
	--                 lsp_zero.default_setup,
	--                 lua_ls = function()
	--                     -- (Optional) Configure lua language server for neovim
	--                     local lua_opts = lsp_zero.nvim_lua_ls()
	--                     require('lspconfig').lua_ls.setup(lua_opts)
	--                 end,
	--             }
	--         })
	--     end
	-- },
	-- Autocompletion
	-- {
	--     'hrsh7th/nvim-cmp',
	--     event = 'InsertEnter',
	--     dependencies = {
	--         { 'L3MON4D3/LuaSnip' },
	--     },
	--     config = function()
	--         -- Here is where you configure the autocompletion settings.
	--         local lsp_zero = require('lsp-zero')
	--         lsp_zero.extend_cmp()
	--
	--         -- And you can configure cmp even more, if you want to.
	--         local cmp = require('cmp')
	--         local cmp_action = lsp_zero.cmp_action()
	--
	--         cmp.setup({
	--             formatting = lsp_zero.cmp_format(),
	--             mapping = cmp.mapping.preset.insert({
	--                 ['<C-Space>'] = cmp.mapping.complete(),
	--                 ['<C-u>'] = cmp.mapping.scroll_docs(-4),
	--                 ['<C-d>'] = cmp.mapping.scroll_docs(4),
	--                 ['<C-f>'] = cmp_action.luasnip_jump_forward(),
	--                 ['<C-b>'] = cmp_action.luasnip_jump_backward(),
	--             })
	--         })
	--     end
	-- },
	-- {
	--     'L3MON4D3/LuaSnip',
	--     version = 'v2.*',
	--     dependencies = { 'rafamadriz/friendly-snippets' },
	--     build = 'make install_jsregexp',
	--     event = 'InsertEnter',
	-- },
	{
		"github/copilot.vim",
		config = load_config("tools.copilot"),
		event = { "BufReadPre", "BufNewFile" },
	},
	-- { import = "plugins.lsp" },
}

local ts_parsers = {
	--     'bash',
	--     'css',
	--     'elixir',
	--     'gitcommit',
	--     'go',
	--     'html',
	--     'java',
	--     'javascript',
	--     'json',
	"lua",
	--     'markdown',
	--     'markdown_inline',
	--     'python',
	--     'ruby',
	--     'rust',
	--     'typescript',
	--     'vim',
	--     'vimdoc',
	--     'yaml',
}

local lsp_servers = {
	--     'bashls',
	--     'eslint',
	--     'elixirls',
	--     'jsonls',
	"lua_ls",
	--     'ruby_ls',
	--     'ruff_lsp',
	--     'rubocop',
	--     'rust_analyzer',
	--     'tsserver',
	--     'typos_lsp',
	--     'vimls',
}

-- local null_ls_sources = {
--     'shellcheck',
-- }

return {
	plugins = plugins,
	ts_parsers = ts_parsers,
	lsp_servers = lsp_servers,
	-- null_ls_sources = null_ls_sources,
}
