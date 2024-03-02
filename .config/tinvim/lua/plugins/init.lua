local function load_config(package)
    return function()
        require('plugins.' .. package)
    end
end

local plugins = {
    -- UI
    {
        "rebelot/kanagawa.nvim",
        enabled = false,
        config = load_config('ui.kanagawa'),
        lazy = false,
        priority = 1000,
    },
    {
        "navarasu/onedark.nvim",
        config = function()
            require('onedark').setup {
                -- Main options --
                style = 'deep', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
                transparent = true,  -- Show/hide background
            }
            require('onedark').load()
        end
    },
    {
        "catppuccin/nvim",
        enabled = false,
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                transparent_background = true,
                styles = {
                    conditionals = {}
                }
            })
            -- load the colorscheme here
            vim.cmd([[colorscheme catppuccin]])
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = load_config("ui.lualine"),
        event = { "BufReadPre", "BufNewFile" },
    },
    -- Tools
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-symbols.nvim",
        },
        config = load_config("tools.telescope"),
        cmd = "Telescope",
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = load_config('tools.nvim-tree'),
        cmd = 'NvimTreeToggle',
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },
    {
        'windwp/nvim-spectre',
        config = load_config('tools.spectre'),
        cmd = 'Spectre',
    },
    {
        'folke/flash.nvim',
        config = load_config('tools.flash'),
        keys = {
            {
                's',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
                desc = 'Flash',
            },
            {
                'S',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').treesitter()
                end,
                desc = 'Flash Treesitter',
            },
            {
                'r',
                mode = 'o',
                function()
                    require('flash').remote()
                end,
                desc = 'Remote Flash',
            },
            {
                'R',
                mode = { 'o', 'x' },
                function()
                    require('flash').treesitter_search()
                end,
                desc = 'Treesitter Search',
            },
            {
                '<c-s>',
                mode = { 'c' },
                function()
                    require('flash').toggle()
                end,
                desc = 'Toggle Flash Search',
            },
        },
    },
    {
        'folke/which-key.nvim',
        config = load_config('tools.which-key'),
        event = 'VeryLazy',
    },
    -- Git
    {
        'lewis6991/gitsigns.nvim',
        config = load_config('tools.gitsigns'),
        cmd = 'Gitsigns',
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'tpope/vim-fugitive',
        cmd = 'Git',
    },

    -- Other
    {
        '2kabhishek/nerdy.nvim',
        dependencies = {
            'stevearc/dressing.nvim',
            'nvim-telescope/telescope.nvim',
        },
        cmd = 'Nerdy',
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
            require("mini.comment").setup()

            -- local hipatterns = require("mini.hipatterns")
            -- hipatterns.setup({
            --     highlighters = {
            --         -- -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
            --         -- fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
            --         -- hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
            --         -- todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
            --         -- note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
            --
            --         -- Highlight hex color strings (`#rrggbb`) using that color
            --         hex_color = hipatterns.gen_highlighter.hex_color(),
            --     },
            -- })
            --
            -- require("mini.surround").setup({
            --     mappings = {
            --         add = "as",
            --         delete = "ds",
            --         replace = "cs",
            --     },
            -- })
            --
            -- require("mini.ai").setup()
        end,
    },
    {
        -- Treesitter is a new parser generator tool that we can
        -- use in Neovim to power faster and more accurate
        -- syntax highlighting.
        {
            "nvim-treesitter/nvim-treesitter",
            version = false, -- last release is way too old and doesn't work on Windows
            build = ":TSUpdate",
            event = { "BufReadPre", "BufNewFile" },
        },
    },
    -- Testing out
    -- {
    --     "m4xshen/hardtime.nvim",
    --     dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    --     opts = {}
    -- },
}

-- local ts_parsers = {
--     'bash',
--     'css',
--     'elixir',
--     'gitcommit',
--     'go',
--     'html',
--     'java',
--     'javascript',
--     'json',
--     'lua',
--     'markdown',
--     'markdown_inline',
--     'python',
--     'ruby',
--     'rust',
--     'typescript',
--     'vim',
--     'vimdoc',
--     'yaml',
-- }
--
-- local lsp_servers = {
--     'bashls',
--     'eslint',
--     'elixirls',
--     'jsonls',
--     'lua_ls',
--     'ruby_ls',
--     'ruff_lsp',
--     'rubocop',
--     'rust_analyzer',
--     'tsserver',
--     'typos_lsp',
--     'vimls',
-- }
--
-- local null_ls_sources = {
--     'shellcheck',
-- }

return {
    plugins = plugins,
    -- ts_parsers = ts_parsers,
    -- lsp_servers = lsp_servers,
    -- null_ls_sources = null_ls_sources,
}

